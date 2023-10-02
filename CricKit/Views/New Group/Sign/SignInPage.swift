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
                
                appSettings.isDarkMode ? LinearGradient(Color.appBlacks, Color.darkStart).ignoresSafeArea() : LinearGradient(Color.appWhites).ignoresSafeArea()
                        
                
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
                            if appSettings.showSkipButton {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        readyToNavigate = true
                                    }) {
                                        Text("Skip for now?")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.appPrimary)
                                    }
                                    .padding(.trailing, 16)
                                    .offset(y: UIScreen.main.bounds.width * 0.4)
                                }
                            }
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
                    }.background(appSettings.isDarkMode ? Color.linearBlackColor : Color.linearWhiteColor)
                        .shadow(radius: 10)
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
            .environmentObject(AppSettings())
    }
}
