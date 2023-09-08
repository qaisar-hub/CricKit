//
//  AuthViewModel.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn
import GoogleSignInSwift

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
    
    func signIn(withEmail email: String, password: String, errorMessage: String) async throws {
        if errorMessage.isEmpty {
            do {
                let result = try await Auth.auth().signIn(withEmail: email, password: password)
                self.userSession = result.user
                await fetchUser()
            } catch {
                self.userStatus = .failed("Sign In Failed", "The email or password you entered is incorrect. Please double-check and try again.")
                print("Failed to sign in with error \(error.localizedDescription)")
            }
        } else {
            self.userStatus = .failed("Sign In Failed", errorMessage)
        }
    }
    
    func checkUserStatus() -> AlertTypes {
        switch self.userStatus {
        case .some(.failed(let title, let message)):
            return AlertTypes.defaulAlert(title: title, message: message)
        case .some(.success(let title, let message)):
            return AlertTypes.defaulAlert(title: title, message: message)
        case .none:
            return AlertTypes.defaulAlert(title: "title", message: "message")
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
            self.userStatus = .failed("Signup Failed", "An error occurred while signing up. Please check the fields again.")
            debugPrint("Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func resetPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                debugPrint(error.localizedDescription)
                self.userStatus = .failed("Error", "\(error.localizedDescription)")
            } else {
                debugPrint("Password reset email sent. Check your inbox.")
                self.userStatus = .success("Email Sent", "Password reset email sent. Check your inbox.")
            }
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
                        self.userStatus = .success("Account Deleted","Your account deleted successfully!")
                        debugPrint("User account deleted successfully.")
                    }
                }
            }
        }
    }
    
    func getProviders() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        print(providers)
        return providers
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func signInGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        guard let name = gidSignInResult.user.profile?.name else { return }
        guard let email = gidSignInResult.user.profile?.email else { return }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        let result = try await Auth.auth().signIn(with: credential)
        
     //   try await createUser(withEmail: email, password: result.user., fullName: name)
        self.userSession = result.user
        let user = User(id: result.user.uid, email: email, fullName: name)
        let encoderUser = try Firestore.Encoder().encode(user)
        try await Firestore.firestore().collection("users").document(user.id).setData(encoderUser)
        await fetchUser()
    }
    
}


enum UserStatus {
   case failed(String, String)
   case success(String, String)
}

enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
}
