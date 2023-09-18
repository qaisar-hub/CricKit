//
//  ContentView.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/09/23.
//

import SwiftUI

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

#Preview {
    ContentView()
}
