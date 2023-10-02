//
//  HomeSectionsView.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import SwiftUI

struct HomeSections: View {
    
    @ObservedObject var sectionProgress : HomeSection
	@EnvironmentObject private var appSettings: AppSettings
    
    // maintaining a separate animation state for each tab
    @State private var isAnimating: [Bool?] = [nil, nil, nil, nil, nil]
    
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
                            .shadow(color: appSettings.isDarkMode ? Color.black : Color.white, radius: 1)
                            .padding()
                            .font(.system(size: 25.0))
							.foregroundColor( sectionProgress.index == index ? Color.appPrimary : Color.gray.opacity(0.8))
                            .opacity(9)
							.background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                            .cornerRadius(10, corners: .allCorners)
							.shadow(color: appSettings.isDarkMode ? Color.black : Color.white, radius: 1)
                            .offset(y: CGFloat(-index*6))
                            .onTapGesture {
                                sectionProgress.index = index
                                withAnimation(.bouncy ,completionCriteria: .logicallyComplete) {
                                    isAnimating[index] = true
                                } completion: {
                                    var trasnaction = Transaction()
                                    trasnaction.disablesAnimations = true
                                    withTransaction (trasnaction) {
                                       isAnimating[index] = nil
                                    }
                                }
                            }
                            .symbolEffect(.bounce.down.byLayer, value: isAnimating[index])

                    }
                }
            }
            SectionTitleView(title: categoryDataTitle[sectionProgress.index])
        }
    }
}
