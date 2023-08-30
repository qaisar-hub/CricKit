//
//  SignInPageErrorMessageView.swift
//  CricKit
//
//  Created by Qaisar Raza on 30/08/23.
//

import SwiftUI

struct SignInPageErrorMessageView: View {
    @Binding var showingFieldAlert: Bool
    @StateObject var progress = TextFieldObserver()
    @State var textFieldType: TextFieldType
    
    
    var body: some View {
            switch textFieldType {
            case .fullName:
                if  showingFieldAlert && !progress.isValidFullName() {
                    ErrorMessageView(errorMessage: "Full name should not be empty")
                }
            case .emailId:
                if showingFieldAlert && !progress.isValidEmail() {
                    ErrorMessageView(errorMessage: "Invalid email format")
                }
            case .password:
                if showingFieldAlert && !progress.isValidPassword() {
                    ErrorMessageView(errorMessage: "Password should be at least 6 characters")
                }
            case .confirmPassword:
                if showingFieldAlert && !progress.doPasswordsMatch() {
                    ErrorMessageView(errorMessage: "Passwords do not match")
                }
            }
    }
}

enum TextFieldType {
    case fullName
    case emailId
    case password
    case confirmPassword
}

struct ErrorMessageView: View {
    var errorMessage: String
    
    var body: some View {
        VStack {
            Text(errorMessage)
                .foregroundColor(.red)
                .font(.system(size: 12))
                .offset(y: -15)
        }
    }
}
