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
    @ObservedObject private var appSettings = AppSettings()
    
    init() {
        FirebaseApp.configure()
        do {
            let container = try ModelContainer(for: UserDataModel.self)
            let context = container.mainContext
            let userDataModel = try context.fetch(FetchDescriptor<UserDataModel>())
            if !userDataModel.isEmpty {
                appSettings.isDarkMode = userDataModel[0].isDarkMode
                appSettings.favouriteTeam = userDataModel[0].favouriteTeam
                debugPrint(userDataModel[0].isDarkMode)
                debugPrint(userDataModel[0].favouriteTeam)
            }
        } catch {
            debugPrint("Error Creating ModelContainer: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchAnimationView()
                .environmentObject(authViewModel)
                .environmentObject(appSettings)
        }
        .modelContainer(for: UserDataModel.self)
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

