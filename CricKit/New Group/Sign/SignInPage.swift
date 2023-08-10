//
//  SignInPage.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 25/07/23.
//

import SwiftUI

struct SignInPage: View {
    
    
    @Namespace var animation
    
    @State var readyToNavigate = false
    @StateObject var progress = TextFieldObserver()
    
    
    @State private var signInColor = Color.appSecondary
    @State private var signUpColor = Color.appPrimary
    
    @State private var isSignInShown = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBlacks
                    .ignoresSafeArea()
                
                HStack {
                    VStack(spacing: 100) {
                        Spacer()
                        RotationButton(label: "SIGN IN", action:{
                            isSignInShown = true
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
                                signInColor = Color.appSecondary
                                signUpColor = Color.appPrimary
                                
                            }
                        })
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(signInColor)
                        
                        RotationButton(label: "SIGN UP", action: {
                            isSignInShown = false
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
                                signInColor = Color.appPrimary
                                signUpColor =  Color.appSecondary
                                
                            }
                        })
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(signUpColor)
                        
                        Spacer()
                        
                    }
                    VStack {
                        if (isSignInShown) {
                            SignInView(readyToNavigate: $readyToNavigate)
                        } else {
                            SignUpView()
                        }
                        
                    }.background(Color.black)
                    .cornerRadius(20, corners: .bottomLeft)
                    .padding(.bottom, 50)
                    .ignoresSafeArea()
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
    }
}
