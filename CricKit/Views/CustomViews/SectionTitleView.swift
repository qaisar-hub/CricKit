//
//  SectionTitleView.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import SwiftUI

struct SectionTitleView: View {
    let title: String
    var body: some View {
        Text(title)
            .foregroundColor(Color.white)
            .padding(.all, 10)
            .font(.footnote)
            .background(Blur(style: .systemChromeMaterialDark))
            .cornerRadius(20, corners: .allCorners)
            .shadow(color: Color.black, radius: 5)
    }
}
