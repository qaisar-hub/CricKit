//
//  ForgotPasswordView.swift
//  CricKit
//
//  Created by Qaisar Raza on 05/09/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var showForgetPasswordSheet: Bool
    @StateObject var progress = TextFieldObserver()
    @State private var alert: AlertTypes? = nil
    @State private var startValidation = false
    
    var body: some View {
            VStack(spacing: 10) {
                Text("Forgot Your Password?")
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                    .font(.title)
                    .fontWeight(.bold)
                    
                
                Text("Enter your email address below, and we'll send you a link to reset your password.")
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                customTextField(placeholderText: "Email ID", spacing: 0.0, textValue: $progress.emailId)
                    .frame(height: 40)
                    .background(Color.darkStart)
                    .cornerRadius(10, corners: .allCorners)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    
                
                Button(action: {
                    authViewModel.resetPassword(withEmail: progress.emailId)
                    alert = authViewModel.checkUserStatus()
                }) {
                    Text("Send Reset Link")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.appPrimary.opacity(0.9))
                        .cornerRadius(10)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.bottom, 15)
                }.padding(.vertical, 10)
                
                HStack {
                    Text("Remember your password?")
                        .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                        .font(.subheadline)
                    Button(action: {
                        showForgetPasswordSheet.toggle()
                    }) {
                        Text("Sign In")
                            .font(.subheadline)
                    }
                }
                
                .presentationDetents([.medium])
            }
            .padding(.all)
            .alert(item: $alert) { value in
                value.alert
            }
            
            
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(showForgetPasswordSheet: .constant(false))
    }
}
