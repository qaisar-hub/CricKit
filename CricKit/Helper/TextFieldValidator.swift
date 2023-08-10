//
//  TextFieldValidator.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 25/07/23.
//

import Foundation
import SwiftUI

class TextFieldObserver: ObservableObject {
    @Published var readyToNavigate = false
    @Published var sheetTextValue = ""
    @Published var checkDigitTextValue = ""
    @Published var canShowError = true
    @Published var upcTextValue = ""
    @Published var quantityTextValue = ""
    @Published var retailTextValue = ""
    @Published var departmentTextValue = ""
    
    func retailFieldEmpty() -> Bool {
        return !retailTextValue.isEmpty
    }
    
    func departmentFieldEmpty() -> Bool {
        return !departmentTextValue.isEmpty
    }
    
    func sheetFieldEmpty() -> Bool {
        return !sheetTextValue.isEmpty
    }
    
    func quantityFieldEmpty() -> Bool {
        return !quantityTextValue.isEmpty
    }
    
    func upcFieldEmpty() -> Bool {
        return !upcTextValue.isEmpty
    }
    
    func checkDigitFieldEmpty() -> Bool {
        return !checkDigitTextValue.isEmpty
    }
    
    func canShowErrorFlag() -> Bool {
        return canShowError
    }
    
    func fieldsEmpty() -> Bool {
        return !sheetTextValue.isEmpty && !checkDigitTextValue.isEmpty
    }
}
