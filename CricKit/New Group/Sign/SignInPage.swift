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
                        .shadow(color: Color.appSecondary, radius: isSignInShown ? 10: 0)
                        
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
                        .shadow(color: Color.appSecondary, radius: isSignInShown ? 0: 10)
                        Spacer()
                    }
					VStack{
						Spacer()
						Image("appLogo")
							.renderingMode(.original)
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 150, height: 200)
							.opacity(0.9)
                        if (isSignInShown) {
                            SignInView(readyToNavigate: $readyToNavigate)
                        } else {
                            SignUpView()
                        }
						Spacer()
                    }.background(Color.black)
                    .cornerRadius(20, corners: .allCorners)
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
