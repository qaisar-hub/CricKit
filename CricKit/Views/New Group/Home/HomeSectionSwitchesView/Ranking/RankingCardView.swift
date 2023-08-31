//
//  RankingCardView.swift
//  swiftuisample
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI

struct MatchFormatCardView: View {
    var name: String
	var width = UIScreen.main.bounds.width - 32
	@EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        VStack {
			HStack{
				Text(name)
					.font(.subheadline)
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
					.padding()
				
				Text("Current Rankings")
					.font(.subheadline)
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
					.padding()
				
				Image("teamInd")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 25, height: 25)
				
				Text("is at #1")
					.font(.subheadline)
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
					.padding()
			}
            
        }
		.frame(width: width, height: 40)
		.background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
		.clipShape(Capsule())
		.cornerRadius(10, corners: .allCorners)
    }
}

struct RankingCardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(["TEST", "ODI", "T20I"], id: \.self) { name in
                        NavigationLink(destination: RankingDetailsView(selectedTab: .batsman)) {
                            MatchFormatCardView(name: name)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
}

struct RankingCardView_Previews: PreviewProvider {
    static var previews: some View {
        RankingCardView()
    }
}
