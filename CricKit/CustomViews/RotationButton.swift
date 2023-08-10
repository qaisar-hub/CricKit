//
//  RotationButton.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 10/08/23.
//

import Foundation
import SwiftUI

struct RotationButton: View {
    var label : String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .rotationEffect(.degrees(-90))
                .fontWidth(.expanded)
        }
    }
}
