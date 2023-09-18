//
//  CricKitApp.swift
//  CricKit
//
//  Created by Qaisar Raza on 05/08/23.
//

import SwiftUI
import Firebase
import SwiftData

@main
struct CricKitApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject private var appSettings = AppSettings()
    @State var showLoading = true
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchAnimationView(showLoading: $showLoading)
                .environmentObject(authViewModel)
                .environmentObject(appSettings)
                .onAppear {
                    updateExistingUserPreference()
                }
        }
        .modelContainer(SwiftDataHelper.shared.container)
    }
    
    func updateExistingUserPreference()  {
        Task {
            await authViewModel.fetchUser()
            let emailID = authViewModel.currentUser?.email ?? ""
            if !emailID.isEmpty {
                var userImage = appSettings.userImage
                SwiftDataHelper.shared.updateExistingUserPreference(emailID: emailID, isDarkMode: &appSettings.isDarkMode, favouriteTeam: &appSettings.favouriteTeam, userImage: &userImage)
                appSettings.userImage = userImage
            }
            withAnimation {
                showLoading = false
            }
        }
    }
}
