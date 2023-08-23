//
//  AuthViewModel.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var userStatus: UserStatus?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            self.userStatus = .loggenIn
            await fetchUser()
        } catch {
            self.userStatus = .error
            print("Failed to sign in with error \(error.localizedDescription)")
        }
    }
    
    func checkUserStatus() -> AlertTypes {
        switch self.userStatus {
        case .error:
            return AlertTypes.defaulAlert(title: "LoginError")
        case .none:
            return AlertTypes.defaulAlert(title: "LoginError")
        case .loggenIn:
            return AlertTypes.defaulAlert(title: "LoginError")
        case .logOut:
            return AlertTypes.defaulAlert(title: "LoginError")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, email: email, fullName: fullName)
            let encoderUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encoderUser)
            await fetchUser()
        } catch {
            debugPrint("Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            debugPrint("Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount(password: String) {
        guard let user = Auth.auth().currentUser else {
            debugPrint("No user signed in.")
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: password)
        
        user.reauthenticate(with: credential) { authResult, error in
            if let error = error {
                debugPrint("Error reauthenticating user: \(error)")
            } else {
                user.delete { deleteError in
                    if let deleteError = deleteError {
                        debugPrint("Error deleting user: \(deleteError)")
                    } else {
                        self.userSession = nil
                        self.currentUser = nil
                        debugPrint("User account deleted successfully.")
                    }
                }
            }
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
}


enum UserStatus {
   case loggenIn
   case error
   case logOut
}
