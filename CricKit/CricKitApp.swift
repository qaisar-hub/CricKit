//
//  CricKitApp.swift
//  CricKit
//
//  Created by Qaisar Raza on 05/08/23.
//

import SwiftUI
import Firebase

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

