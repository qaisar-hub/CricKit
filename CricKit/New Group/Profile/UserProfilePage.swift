//
//  UserProfilePage.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import SwiftUI

struct UserProfilePage: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var password = ""
    @State private var isSignOut = false
    @State private var confirmDeletion = false
    @State var isLoading: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Profile Information")) {
                ProfileCard(initials: authViewModel.currentUser?.initials ?? "", fullName: authViewModel.currentUser?.fullName ?? "", emailID: authViewModel.currentUser?.email ?? "")
            }
            
            Section(header: Text("App Settings")) {
                SettingsRowView(imageName: "gear", title: "Version", subtitle: "1.0.0", tintColor: .gray)
            }
            
            Section(header: Text("Account Actions")) {
                
                // Sign out button
                Button(action: {
                    isSignOut.toggle()
                }) {
                    SettingsRowView(imageName: "arrow.right.circle.fill", title: "Sign out", subtitle: "", tintColor: .red)
                }.alert("Sign Out", isPresented: $isSignOut) {
                    Button("Sign Out", action: {
                        authViewModel.signOut()
                    })
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure you want to sign out?")
                }
                
                // Delete Action
                Button(action: {
                    confirmDeletion.toggle()
                }) {
                    SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", subtitle: "", tintColor: .red)
                }.alert("Confirm Account Deletion", isPresented: $confirmDeletion) {
                    SecureField("Password", text: $password)
                    Button("Delete", action: {
                        authViewModel.deleteAccount(password: password)
                    })
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Enter your password for \"\(authViewModel.currentUser?.email ?? "")\" to confirm the account deletion.")
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


