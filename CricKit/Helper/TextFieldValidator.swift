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
    
    func isValidFullName() -> Bool {
        return !fullName.isEmpty
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailId)
    }
    
    func isValidPassword() -> Bool {
        return password.count >= 6
    }
    
    func doPasswordsMatch() -> Bool {
        return password == confirmPassword
    }
    
    func isValidAllFields() -> Bool {
            let isFullNameValid = isValidFullName()
            let isEmailValid = isValidEmail()
            let isPasswordValid = isValidPassword()
            let doPasswordsMatch = doPasswordsMatch()

            return isFullNameValid && isEmailValid && isPasswordValid && doPasswordsMatch
    }
}
