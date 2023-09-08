//
//  TextFieldValidator.swift
//  CricKit
//
//  Created by ephrim.daniel on 25/07/23.
//

import Foundation
import SwiftUI

class TextFieldObserver: ObservableObject {
    @Published var emailId = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var fullName = ""
    
    func validateFullName() -> String {
        var errorMessage = ""
        if (fullName.isEmpty) {
            errorMessage = "Full name should not be empty."
        }
        return errorMessage
    }
    
    func validateEmail() -> String {
        var errorMessage = ""
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        if (emailId.isEmpty) {
            errorMessage = "Email Id should not be empty."
        } else if (!NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailId)) {
            errorMessage = "Invalid Email ID"
        }
        return errorMessage
    }
    
    func validatePassword() -> String {
        var errorMessage = ""
        if (password.isEmpty) {
            errorMessage = "Password should not be empty"
        } else if (password.count <= 6) {
            errorMessage = "Password should be at least 6 characters."
        }
        return errorMessage
    }
    
    func validateConfirmPassword() -> String {
        var errorMessage = ""
        if (confirmPassword.isEmpty) {
            errorMessage = "Confirm Password should not be empty."
        } else if (password != confirmPassword) {
            errorMessage = "Passwords do not match."
        }
        return errorMessage
    }
    
    func validateSignInFields() -> String {
        var errorMessage = ""
        
        if (emailId.isEmpty && password.isEmpty) {
            errorMessage = "Please enter your email and password."
        } else if emailId.isEmpty {
            errorMessage =  "Please enter your email."
        } else if password.isEmpty {
            errorMessage = "Please enter your password."
        }
        
        return errorMessage
    }
    
}
