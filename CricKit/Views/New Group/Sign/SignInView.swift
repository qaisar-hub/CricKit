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
    @EnvironmentObject var appSettings: AppSettings
    @Binding var isLoading: Bool
    @State private var isTapped = false
    @State private var showingAlert = false
    @State private var alert: AlertTypes? = nil

    @State private var isEmailValid = false
    @State private var isPasswordValid = false
    
    @State var showForgetPasswordSheet = false
    
    var body: some View {
		VStack (spacing: 10) {
            Text("Please sign in to continue.")
                .padding(.bottom, 16)
                .fontWidth(.expanded)
                .font(.system(size: 12))
				.foregroundColor(Color.appWhites)
            customTextField(placeholderText: "Email ID", spacing: 0.0, textValue: $progress.emailId)
				.frame(height: 40)
				.background(Color.darkStart)
				.cornerRadius(10, corners: .allCorners)
				.padding(.leading, 15)
				.padding(.trailing, 15)
				.padding(.bottom, 15)
            
            customTextField(placeholderText: "Password", spacing: 0.0, textValue: $progress.password, isSecureField: true)
				.frame(height: 40)
				.background(Color.darkStart)
				.cornerRadius(10, corners: .allCorners)
				.padding(.leading, 15)
				.padding(.trailing, 15)
			
            
            Button(action: {
                showForgetPasswordSheet.toggle()
            }) {
                Text("Forgot Password ?")
                    .padding()
                    .fontWeight(.semibold)
                    .fontWidth(.expanded)
                    .font(.system(size: 12))
                    .foregroundColor(.appWhites)
            }.sheet(isPresented: $showForgetPasswordSheet) {
                ZStack {
                    appSettings.isDarkMode ? Color.linearBlackColor : Color.linearWhiteColor
                    ForgotPasswordView(showForgetPasswordSheet: $showForgetPasswordSheet)
                }.ignoresSafeArea()
                    
            }
            
            
            HStack {
				EmbossedButton(systemName: "arrow.right") {
                    isLoading = true
					Task {
						try await authViewModel.signIn(withEmail: progress.emailId, password: progress.password)
						isLoading = false
						alert = authViewModel.checkUserStatus()
					}
				}.padding()
            }
            
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
            .padding()
			
			HStack (spacing: 20) {
				GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .icon, state: .normal)) {
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
				.clipShape(Circle())
				
				Button(action: {}) {
						Image(systemName: "apple.logo")
							.padding()
							.background(Color.white)
							.foregroundColor(Color.black)
							.clipShape(Circle())
							.shadow(radius: 8)
				}
				.frame(width: 42, height: 42)
				.clipShape(Circle())
				
				Button(action: {}) {
						Image(systemName: "f.cursive")
							.padding()
							.background(Color.blue)
							.foregroundColor(Color.white)
							.clipShape(Circle())
							.shadow(radius: 8)
				}
				.frame(width: 42, height: 42)
				.clipShape(Circle())

            }
            
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
            .environmentObject(AppSettings())
    }
}

