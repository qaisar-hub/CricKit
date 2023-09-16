//
//  LiveMatches.swift
//  CricKit
//
//  Created by ephrim.daniel on 16/09/23.
//

import SwiftUI

struct LiveMatches: View {
	
	@ObservedObject var liveScoreCardViewModel = LiveScoreCardViewModel()
	@EnvironmentObject private var appSettings: AppSettings
	var width = UIScreen.main.bounds.width
	
	var body: some View {
		VStack {
			ScrollView(.vertical, showsIndicators: false){
				VStack{
					if liveScoreCardViewModel.isLoading {
						LiveScoreCardShimmerView(width: width - 32)
							.offset(x: 16)
					} else {
						ForEach(Array(liveScoreCardViewModel.liveScoreCardlists.enumerated()), id: \.element.id) { index, liveScoreItem in
							NavigationLink(destination: LiveModePage(matchHeader: liveScoreItem.matchHeader, matchStatus: liveScoreItem.matchStatus)) {
								LiveScoreCardView(isLiveMatches: true, liveScoreCardData: liveScoreItem)
									.frame(width: width - 32, height: 160)
									.clipShape(LiveMatchCard())
									.background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
									.clipShape(LiveMatchCard())
									.cornerRadius(10, corners: .allCorners)
							}.accentColor(Color.gray)
						}
					}
				}
			}
		}
	}
	init() {
		liveScoreCardViewModel.getLiveScore()
	}
}

#Preview {
	LiveMatches()
}
