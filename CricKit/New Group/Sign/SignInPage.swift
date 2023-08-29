//
//  SignInPage.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 25/07/23.
//

import SwiftUI
import Shimmer

struct SignInPage: View {
    
    @State var readyToNavigate = false
    @StateObject var progress = TextFieldObserver()
    @State var isLoading: Bool = false
    
    
    @State private var signInColor = Color.appPrimary
    @State private var signUpColor = Color.appSecondary
    
    @State private var isSignInShown = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                CustomBackgroundView()
                    .ignoresSafeArea()
                
                HStack {
                    VStack(spacing: 100) {
                        Spacer()
                        RotationButton(label: "SIGN IN", action:{
                            isSignInShown = true
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
                                signInColor = Color.appPrimary
                                signUpColor = Color.appSecondary
                                
                            }
                        })
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(signInColor)
                        .shadow(color: signInColor, radius: isSignInShown ? 10: 0)
                        
                        RotationButton(label: "SIGN UP", action: {
                            isSignInShown = false
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
                                signInColor = Color.appSecondary
                                signUpColor = Color.appPrimary
                                
                            }
                        })
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(signUpColor)
                        .shadow(color: signUpColor, radius: isSignInShown ? 0: 10)
                        Spacer()
                    }
                    VStack{
                        Spacer()

                        if (isSignInShown) {
                            Text("Welcome Back")
                                .fontWidth(.expanded)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundStyle(
                                    .linearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .offset(y: -12)
                            
                            SignInView(readyToNavigate: $readyToNavigate, isLoading: $isLoading)
                        } else {
                            Text("Create Account")
                                .fontWidth(.expanded)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundStyle(
                                    .linearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .offset(y: -12)
                        
                            SignUpView(isLoading: $isLoading)
                        }
                        Spacer()
                    }.background(CustomBackgroundView())
                    .cornerRadius(20, corners: .allCorners)
                    .shadow(color: Color.appBlacks, radius: 20)
                    .ignoresSafeArea()
                }
                if isLoading {
                    LoadingIndicator()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationDestination(isPresented: $readyToNavigate) {
                HomePage()
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color.black,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
            
        }
    }
}

struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
            .environmentObject(AuthViewModel())
    }
}
