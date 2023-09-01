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
    @EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        Form {
            Section(header: SectionHeaderView(title: "Profile Information")) {
                ProfileCard(initials: authViewModel.currentUser?.initials ?? "", fullName: authViewModel.currentUser?.fullName ?? "", emailID: authViewModel.currentUser?.email ?? "")
            }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
            
            Section(header: SectionHeaderView(title: "Favourite Team")) {
                FavouriteTeamView(chosenTeam: "India", chosenFlag: "teamInd")
            }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
            
            Section(header: SectionHeaderView(title: "App Settings")) {
                SettingsRowView(iconName: "gear", title: "Version", subtitle: "1.0.0", tintColor: .gray)
                Toggle(isOn: $appSettings.isDarkMode) {
                    HStack {
                        Image(systemName: "moonphase.last.quarter")
                            .imageScale(.small)
                            .font(.title)
                            .foregroundColor(.gray)
                        Text("Dark Mode")
                            .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                    }
                }.toggleStyle(SwitchToggleStyle(tint: Color.red))
            }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
            
            Section(header: SectionHeaderView(title: "Account Actions")) {
                // Sign out button
                Button(action: {
                    isSignOut.toggle()
                }) {
                    SettingsRowView(iconName: "rectangle.portrait.and.arrow.forward", title: "Sign out", subtitle: "", tintColor: .red)
                }.alert("Sign Out", isPresented: $isSignOut) {
                    Button("Sign Out", action: {
                        authViewModel.signOut()
                    })
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure you want to sign out?")
                }
                
                // Delete Action
                if let providers = try? authViewModel.getProviders() {
                    if providers.contains(.email) {
                        Button(action: {
                            confirmDeletion.toggle()
                        }) {
                            SettingsRowView(iconName: "xmark.circle", title: "Delete Account", subtitle: "", tintColor: .red)
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
                
            }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
            
        }
        .padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 0))
        .scrollContentBackground(.hidden)
    }
}

struct SectionHeaderView: View {
    let title: String
    @EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            .padding(EdgeInsets(top: 8, leading: -15, bottom: 8, trailing: 15))
    }
}


struct UserProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
            .environmentObject(AuthViewModel())
    }
}


