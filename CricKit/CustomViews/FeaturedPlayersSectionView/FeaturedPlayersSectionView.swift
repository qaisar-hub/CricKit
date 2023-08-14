//
//  FeaturedPlayersSectionView.swift
//  CricKit
//
//  Created by ephrim.daniel on 14/08/23.
//

import SwiftUI

struct FeaturedPlayersSectionView: View {
    
    var categoryDataImages: [String] = ["playerVirat", "playerJoeRoot", "playerBabar", "playerSteveSmith", "playerKaneWill"]
    
    var categoryDataPlayerName: [String] = ["Virat Kohli [Player desc for 2/3 lines]", "Joe Root [Player desc for 2/3 lines]", "Babar Azam [Player desc for 2/3 lines]", "Steve Smith [Player desc for 2/3 lines]", "Kane Williamson [Player desc for 2/3 lines]"]
    
    var body: some View {
        VStack {
            SectionTitleView(title: "Featured Players")
            ForEach(Array(categoryDataImages.enumerated()), id: \.offset) { index, category in
                let imageName = categoryDataImages[index]
                HStack {
                    VStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    }
                    .padding(.all, 8)
                    Text(categoryDataPlayerName[index])
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .background(Blur(style: .systemChromeMaterialDark))
                .cornerRadius(20, corners: .allCorners)
            }
        }
    }
}

struct SectionTitleView: View {
    let title: String
    var body: some View {
        Text(title)
            .foregroundColor(Color.white)
            .padding(.all, 5)
            .font(.footnote)
            .background(Blur(style: .systemChromeMaterialDark))
            .cornerRadius(20, corners: .allCorners)
    }
}
