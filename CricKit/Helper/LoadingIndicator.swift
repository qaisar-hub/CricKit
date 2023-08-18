//
//  LoadingIndicator.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import SwiftUI

import SwiftUI

struct LoadingIndicator: View {
    var body: some View {
        VStack {
            ProgressView {
                Text("LOADING")
                    .foregroundColor(Color(.systemGray3))
                    .font(.footnote)
            }.tint(Color(.systemGray3))
            .padding()
            .background(Blur(style: .systemChromeMaterialDark))
            .cornerRadius(10)
            .shadow(radius: 5)
            
        }
        .padding()
        //.background(Blur(style: .systemChromeMaterial))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
