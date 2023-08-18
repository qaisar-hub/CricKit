//
//  UserProfilePage.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import SwiftUI

enum AlertType: Identifiable {
        case signOut, confirmDeletion
        var id: Int { hashValue }
}

struct UserProfilePage: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var password = ""
    @State private var showingAlert: AlertType? = nil
    
    var body: some View {
        Form {
                    Section(header: Text("Profile Information")) {
                        ProfileCard(initials: authViewModel.currentUser?.initials ?? "", fullName: authViewModel.currentUser?.fullName ?? "", emailID: authViewModel.currentUser?.email ?? "")
                    }
                    
                    Section(header: Text("App Settings")) {
                        SettingsRowView(imageName: "gear", title: "Version", subtitle: "1.0.0", tintColor: .gray)
                    }
                    
                Section(header: Text("Account Actions")) {
                    Button(action: {
                        showingAlert = .signOut
                    }) {
                        SettingsRowView(imageName: "arrow.right.circle.fill", title: "Sign Out", subtitle: "", tintColor: .red)
                    }
                    
                    Button(action: {
                        showingAlert = .confirmDeletion
                    }) {
                        SettingsRowView(imageName: "trash.fill", title: "Delete Account", subtitle: "", tintColor: .red)
                    }.alert(item: $showingAlert) { alertType in
                        switch alertType {
                        case .signOut:
                            return Alert(
                                title: Text("Sign Out"),
                                message: Text("Are you sure you want to sign out?"),
                                primaryButton: .default(Text("Sign Out"), action: {
                                    authViewModel.signOut()
                                }),
                                secondaryButton: .cancel()
                            )
                        case .confirmDeletion:
                            return Alert(
                                title: Text("Confirm Account Deletion"),
                                message: Text("Enter your password to confirm the account deletion."),
                                primaryButton: .destructive(Text("Delete"), action: {
                                    authViewModel.deleteAccount(password: password)
                                }),
                                secondaryButton: .cancel()
                            )
                        }
                    }
                }
            }
            .background(Color.linearColor)
    }
}




struct UserProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        UserProfilePage()
            .environmentObject(AuthViewModel())
    }
}


