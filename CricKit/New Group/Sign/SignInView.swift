//
//  signInView.swift
//  CricKit
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

struct SignInView: View {
    
    //@State private var readyToNavigate = false
    @Binding var readyToNavigate: Bool
    @StateObject var progress = TextFieldObserver()
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isLoading: Bool
    @State private var isTapped = false
    @State private var showingAlert = false
    @State private var alert: AlertTypes? = nil
    
    
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
                    //alert = .defaulAlert(title: "Hello", message: "world")
                    /// readyToNavigate = true
                    /// To By Pass SignIn Page uncomment the above and comment the below lines
                    isLoading = true
                    withAnimation {
                        isTapped.toggle()
                    }
                    Task {
                        try await authViewModel.signIn(withEmail: progress.emailId, password: progress.password)
                        isLoading = false
                        alert = authViewModel.checkUserStatus()
                        
                        if alert != nil {
                            withAnimation {
                                isTapped.toggle()
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 5) {
                        if isTapped {
                            Text(isLoading ? "Signing In" : "Sign In")
                                .fontWeight(.medium)
                                .padding(.leading, 10)
                        }
                        Image(systemName: "arrow.right")
                            .font(.subheadline)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                            .background(Color.appBlacks)
                            .clipShape(Circle())
                        
                        if !isTapped {
                            Text(isLoading ? "Signing In" : "Sign In")
                                .fontWeight(.medium)
                                .padding(.trailing, 10)
                        }
                        
                    }
                    .padding(2)
                    .background(.white)
                    .clipShape(Capsule())
                    .padding(.trailing, 10)

                }
            }
            .padding()
            
            HStack(spacing: 8) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                
                Text("OR")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                    isLoading = true
                    Task {
                        do {
                            try await authViewModel.signInGoogle()
                        } catch {
                            print(error)
                        }
                        isLoading = false
                    }
                }
            .padding(.horizontal)
                SignInWithAppleButton { request in
                    
                } onCompletion: { result in
                    
                }
                .signInWithAppleButtonStyle(.white)
                .frame(height: 44)
                .padding()
            
            
        }
        .alert(item: $alert) { value in
            return value.alert
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
            .environmentObject(AuthViewModel())
    }
}

