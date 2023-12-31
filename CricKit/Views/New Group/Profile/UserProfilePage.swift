//
//  UserProfilePage.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import SwiftUI
import TipKit

struct UserProfilePage: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var password = ""
    @State private var isSignOut = false
    @State private var confirmDeletion = false
    @State var isLoading: Bool = false
    @EnvironmentObject private var appSettings: AppSettings
    @State private var alert: AlertTypes? = nil

    
    var body: some View {
        ZStack{
            Form {
                Section(header: SectionHeaderView(title: "Profile Information")) {
                    ProfileCard(onUserImageChange: addOrUpdateUserDataModel, initials: authViewModel.currentUser?.initials ?? "", fullName: authViewModel.currentUser?.fullName ?? "", emailID: authViewModel.currentUser?.email ?? "")
                }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                
                Section(header: SectionHeaderView(title: "Favourite Team")) {
                    FavouriteTeamView(onFavouriteTeamChange: addOrUpdateUserDataModel)
                }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                
                Section(header: SectionHeaderView(title: "App Settings")) {
                    SettingsRowView(iconName: "gear", title: "Version", subtitle: "1.0.0", tintColor: .gray)
                    Toggle(isOn: $appSettings.isDarkMode) {
                        HStack(spacing: 12) {
                            Image(systemName: "moonphase.last.quarter")
                                .imageScale(.small)
                                .font(.title)
                                .foregroundColor(.gray)
                            Text("Dark Mode")
                                .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                        }
                    }.toggleStyle(SwitchToggleStyle(tint: Color.red))
                        .onChange(of: appSettings.isDarkMode) { _, _ in
                            addOrUpdateUserDataModel()
                        }
                }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                
                Section(header: SectionHeaderView(title: "Account Actions")) {
                    
                    Button(action: {
                        isSignOut.toggle()
                    }) {
                        SettingsRowView(iconName: "rectangle.portrait.and.arrow.forward", title: "Sign out", subtitle: "", tintColor: .red)
                    }.alert("Sign Out", isPresented: $isSignOut) {
                        Button("Sign Out", action: {
                            isLoading = true
                            if authViewModel.signOut() {
                                appSettings.resetToInitialState()
                                isLoading = false
                            }
                        })
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("Are you sure you want to sign out?")
                    }
                    
                    
                    if let providers = try? authViewModel.getProviders() {
                        if providers.contains(.email) {
                            Button(action: {
                                confirmDeletion.toggle()
                            }) {
                                SettingsRowView(iconName: "xmark.circle", title: "Delete Account", subtitle: "", tintColor: .red)
                            }.alert("Confirm Account Deletion", isPresented: $confirmDeletion) {
                                SecureField("Password", text: $password)
                                Button("Delete", action: {
                                    isLoading = true
                                    authViewModel.deleteAccount(password: password) { userStatus, emailID in
                                        switch userStatus {
                                        case .success(_, _):
                                            appSettings.deleteUserPreference(emailID)
                                            appSettings.resetToInitialState()
                                        case .failed(let title, let message):
                                            alert = AlertTypes.defaulAlert(title: title, message: message)
                                        }
                                        isLoading = false
                                    }
                                })
                                Button("Cancel", role: .cancel) { }
                            } message: {
                                Text("Enter your password for \"\(authViewModel.currentUser?.email ?? "")\" to confirm the account deletion.")
                            }
                        }
                    }
                    
                }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                
            }
            if isLoading {
                LoadingIndicator()
            }
        }
        .alert(item: $alert) { value in
            return value.alert
        }
        .padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 0))
        .scrollContentBackground(.hidden)
    }
    
    func addOrUpdateUserDataModel() {
        let emailID = authViewModel.currentUser?.email ?? ""
        appSettings.addOrUpdateUserDataModel(emailID)
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


