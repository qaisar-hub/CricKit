//
//  Alerts.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 23/08/23.
//

import Foundation
import SwiftUI

enum AlertTypes: Identifiable {
    
    var id: String {
        switch self {
        case .defaulAlert:
            return "ok"
        }
    }
        
    case defaulAlert(title: String,
                       message: String? = nil)
    var alert: Alert {
        switch self {
        case .defaulAlert(title: let title,
                            message: let message):
            
            return Alert(title: Text(title),
                         message: message != nil ? Text(message!) : nil)
        }
    }
}
