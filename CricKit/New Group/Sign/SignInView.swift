//
//  signInView.swift
//  CricKit
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI

struct SignInView: View {
    
    //@State private var readyToNavigate = false
    @Binding var readyToNavigate: Bool
    
    @StateObject var progress = TextFieldObserver()
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isLoading: Bool
    
    
    var body: some View {
        VStack {
            Text("SIGN IN")
                .padding()
                .fontWidth(.expanded)
                .font(.system(size: 25))
                .fontWeight(.bold)
                .foregroundStyle(
                    .linearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            customTextField(placeholderText: "Email ID", spacing: 0.0, textValue: $progress.emailId)
            
            customTextField(placeholderText: "Password", spacing: 0.0, textValue: $progress.password)
            
            
            Text("Forgot Password ?")
                .padding()
                .fontWidth(.expanded)
                .font(.system(size: 12))
                .foregroundStyle(
                    .linearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            
            HStack {
                Spacer()
                Button {
                    /// readyToNavigate = true
                    /// To By Pass SignIn Page uncomment the above and comment the below lines
                    isLoading = true
                    Task {
                        try await authViewModel.signIn(withEmail: progress.emailId, password: progress.password)
                        isLoading = false
                    }
                } label: {
                    Image(systemName: "arrow.right")
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.appSecondary)
                        .background(Color.appBlacks)
                        .clipShape(Circle())
                        .padding()
                }
            }
        }
    }
}
