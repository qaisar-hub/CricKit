//
//  User.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let fullName: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
    
}

extension User {
    static var MOCK_USER = User(id: UUID().uuidString, email: "Mock User", fullName: "mock_user@gmail.com")
}
