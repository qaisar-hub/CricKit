//
//  HomeSectionsView.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import SwiftUI

struct HomeSections: View {
    
    @ObservedObject var sectionProgress : HomeSection
    
    var width = UIScreen.main.bounds.width / 7
    var categoryDataImages: [String] = ["clock.fill", "rectangle.fill.on.rectangle.fill", "shared.with.you", "newspaper.fill", "stairs"]
    var categoryDataTitle: [String] = ["Recents", "Upcoming Matches", "Featured Players", "News", "Rankings"]
    
    var body: some View{
        VStack {
            HStack (spacing: 10) {
                ForEach(Array(categoryDataImages.enumerated()), id: \.offset) { index, category in
                    let imageName = categoryDataImages[index]
                    VStack {
                        Image(systemName: imageName)
                            .shadow(color: Color.black, radius: 5)
                            .padding()
                            .font(.system(size: 25.0))
                            .foregroundColor( sectionProgress.index == index ? Color.appPrimary : Color.appWhites)
                            .opacity(9)
                            .background(Blur(style: .systemChromeMaterialDark))
                            .cornerRadius(10, corners: .allCorners)
                            .shadow(color: Color.black, radius: 5)
                            .offset(y: CGFloat(-index*6))
                            .onTapGesture {
                                sectionProgress.index = index
                            }
                    }
                }
            }
            SectionTitleView(title: categoryDataTitle[sectionProgress.index])
        }
    }
}
