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
            appSettings.updateExistingUserPreference(emailID)
            withAnimation {
                showLoading = false
            }
        }
    }
}
