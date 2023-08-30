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
    @EnvironmentObject private var appSettings: AppSettings
    
    
    @State private var signInColor = Color.appPrimary
    @State private var signUpColor = Color.appSecondary
    
    @State private var isSignInShown = true
    
    var body: some View {
        NavigationStack {
            ZStack {
				LinearGradient(Color.darkStart, Color.darkEnd)
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
						.shadow(color: Color.black, radius: isSignInShown ? 8: 0)
                        
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
						.shadow(color: Color.black, radius: isSignInShown ? 0: 8)
                        Spacer()
                    }
                    VStack{
                        Spacer()

                        if (isSignInShown) {
                            Text("Welcome Back")
                                .fontWidth(.expanded)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
								.foregroundColor(.appWhites)
                                .offset(y: -12)
                            
                            SignInView(readyToNavigate: $readyToNavigate, isLoading: $isLoading)
                        } else {
                            Text("Create Account")
                                .fontWidth(.expanded)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
								.foregroundColor(.appWhites)
                                .offset(y: -12)
                        
                            SignUpView(isLoading: $isLoading)
                        }
                        Spacer()
                    }.background(LinearGradient(Color.darkStart, Color.darkEnd))
						.shadow(color: Color.black.opacity(0.8), radius: 20)
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
