//
//  LiveMatches.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/09/23.
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
                        LiveScoreCardShimmerView(width: width - 50)
                            
                    } else {
                        ForEach(Array(liveScoreCardViewModel.liveScoreCardlists.enumerated()), id: \.element.id) { index, liveScoreItem in
                            NavigationLink(destination: LiveModePage(matchHeader: liveScoreItem.matchHeader, matchStatus: liveScoreItem.matchStatus)) {
                                LiveScoreCardView(isLiveMatches: true, liveScoreCardData: liveScoreItem)
                                    .frame(width: width - 50, height: 160)
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
