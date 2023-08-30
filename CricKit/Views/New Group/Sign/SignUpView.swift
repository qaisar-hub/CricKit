//
//  signUpView.swift
//  CricKit
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var readyToNavigate = false
    @StateObject var progress = TextFieldObserver()
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isLoading: Bool
    @State private var isTapped = false
    @State private var showingFieldAlert = false
    @State private var alert: AlertTypes? = nil
    
    var body: some View {
        VStack() {
            Text("Please fill the details and create account.")
                .padding(.bottom, 16)
                .fontWidth(.expanded)
                .font(.system(size: 12))
                .foregroundColor(Color.appWhites)
            customTextField(placeholderText: "Full Name", spacing: 0.0, textValue: $progress.fullName, isSecureField: false)
                .frame(height: 40)
                .background(Color.darkStart)
                .cornerRadius(10, corners: .allCorners)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 15)
            if showingFieldAlert && !progress.isValidFullName() {
                Text("Full name should not be empty")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .offset(y: -15)
            }
            
            customTextField(placeholderText: "Email ID", spacing: 0.0, textValue: $progress.emailId, isSecureField: false)
                .frame(height: 40)
                .background(Color.darkStart)
                .cornerRadius(10, corners: .allCorners)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 15)
            if showingFieldAlert && !progress.isValidEmail() {
                Text("Invalid email format")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .offset(y: -15)
            }
            
            customTextField(placeholderText: "New Password", spacing: 0.0, textValue: $progress.password, isSecureField: true)
                .frame(height: 40)
                .background(Color.darkStart)
                .cornerRadius(10, corners: .allCorners)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 15)
            if showingFieldAlert && !progress.isValidPassword() {
                Text("Password should be at least 6 characters")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .offset(y: -15)
            }
            
            customTextField(placeholderText: "Confirm Password", spacing: 0.0, textValue: $progress.confirmPassword, isSecureField: true)
                .frame(height: 40)
                .background(Color.darkStart)
                .cornerRadius(10, corners: .allCorners)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 15)
            if showingFieldAlert && !progress.doPasswordsMatch() {
                Text("Passwords do not match")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .offset(y: -15)
            }
            
            HStack {
                EmbossedButton(systemName: "arrow.right") {
                    isLoading = true
                    if progress.isValidAllFields() {
                        Task {
                            try await authViewModel.createUser(withEmail: progress.emailId
                                                               ,password: progress.password, fullName: progress.fullName)
                            isLoading = false // stop loading indicator
                            alert = authViewModel.checkUserStatus()
                        }
                    } else {
                        isLoading = false
                        showingFieldAlert = true
                    }
                }
                .padding()
            }
        }
        .cornerRadius(20, corners: [ .bottomLeft, .topLeft])
        .padding(.bottom)
        .alert(item: $alert) { value in
            return value.alert
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isLoading: .constant(false))
            .environmentObject(AuthViewModel())
    }
}
