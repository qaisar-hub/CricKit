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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchAnimationView()
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
                SwiftDataHelper.shared.updateExistingUserPreference(emailID: emailID, isDarkMode: &appSettings.isDarkMode, favouriteTeam: &appSettings.favouriteTeam)
            }
        }
    }
}



struct LaunchAnimationView: View {
    @State private var isAnimationComplete = false
    
    var body: some View {
        ZStack {
            CustomBackgroundView()
            
            if isAnimationComplete {
                ContentView()
                    .transition(.opacity)
            } else {
                AnimatedLogoView(isAnimationComplete: $isAnimationComplete)
                    .transition(.opacity)
            }
        }
        .ignoresSafeArea()
    }
}


struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject private var appSettings: AppSettings
    var body: some View {
        if authViewModel.userSession != nil {
            HomePage()
        } else {
            SignInPage()
        }
    }
}

