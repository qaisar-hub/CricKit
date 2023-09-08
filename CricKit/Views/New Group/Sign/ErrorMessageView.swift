//
//  ErrorMessageView.swift
//  CricKit
//
//  Created by Qaisar Raza on 30/08/23.
//

import SwiftUI

struct ErrorMessageView: View {
    var errorMessage: String
    
    var body: some View {
        VStack {
            Text(errorMessage)
                .foregroundColor(Color.appWhites)
                .fontWeight(.semibold)
                .shadow(color: .black, radius: 10)
                .font(.system(size: 12))
                .offset(y: -15)
        }
    }
}
