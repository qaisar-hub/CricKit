//
//  RoundedRectangleView.swift
//  CricKit
//
//  Created by Qaisar Raza on 10/08/23.
//

import SwiftUI

struct RoundedRectangleView: View {
    var topLeftText: String
    var bottomRightText: String
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.black)
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                
                VStack(alignment: .leading,spacing: 30) {
                    Text(topLeftText)
                        .font(.headline)
                        .foregroundColor(Color.appSecondary)
                        .fontWeight(.heavy)
                    HStack {
                        Spacer()
                        Text(bottomRightText)
                            .font(.subheadline)
                            .foregroundColor(Color.appSecondary)
                            .fontWeight(.heavy)
                            .lineLimit(1)
                    }
                }
                .padding(.horizontal, 10)
        
            }
    }
}

struct RoundedRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleView(topLeftText: "left", bottomRightText: "right")
    }
}
