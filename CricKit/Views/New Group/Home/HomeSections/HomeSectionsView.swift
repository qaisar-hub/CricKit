//
//  HomeSectionSwitchesView.swift
//  CricKit
//
//  Created by Qaisar Raza on 19/09/23.
//

import SwiftUI

struct HomeSectionSwitches: View {
    let categoryDataImages: [String] = ["playerVirat", "playerJoeRoot", "playerBabar", "playerSteveSmith", "playerKaneWill"]
    
    @StateObject var recentMatchesViewModel = RecentMatchesViewModel()
    @StateObject var upComingMatchesViewModel = UpComingMatchViewModel()
    @StateObject var featuredPlayersViewModel = FeaturedPlayersViewModel()
    @StateObject var sectionProgress = HomeSection()
    @StateObject var newsViewsModel = NewsViewModel()
    
    @EnvironmentObject private var appSettings: AppSettings
    @State private var isScrollable = false
    
    var width = UIScreen.main.bounds.width - 32
    
    var body: some View {
        VStack(spacing: 10) {
            if (sectionProgress.index == 0) {
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        if recentMatchesViewModel.isLoading {
                            RecentMatchShimmerView(width: width)
                        }else {
                            ForEach(recentMatchesViewModel.recentMatches, id: \.self) { recentMatch in
                                RecentMatchView(recentMatchModel: recentMatch)
                                    .frame(width: width, height: 120)
                                    .background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                                    .clipShape(LiveMatchCard())
                                    .cornerRadius(10, corners: .allCorners)
                            }
                        }
                    }
                }
            } else if (sectionProgress.index == 1) {
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        ForEach(upComingMatchesViewModel.upComingMatches, id: \.self) { upComingMatch in
                            UpComingMatchesView(upComingMatchModel: upComingMatch)
                                .frame(width: width, height: 120)
                                .background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                                .clipShape(LiveMatchCard())
                                .cornerRadius(10, corners: .allCorners)
                        }
                    }
                }
            } else if (sectionProgress.index == 2) {
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        ForEach(Array(featuredPlayersViewModel.featuredPlayers.enumerated()), id: \.element.id) { index, featuredPlayer in
                            FeaturedPlayersSectionView(featuredPlayer: featuredPlayer, playerImage: categoryDataImages[index])
                                .background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                                .clipShape(LiveMatchCard())
                                .cornerRadius(20, corners: .allCorners)
                        }
                    }
                }
            } else if (sectionProgress.index == 3) {
                CricketNews(newsModel: newsViewsModel.newsModel)
            } else if (sectionProgress.index == 4) {
                RankingCardView()
            }
            
        }
        .padding(.horizontal)
        .onAppear {
            recentMatchesViewModel.getRecentMatches()
            upComingMatchesViewModel.geUpComingMatches()
            featuredPlayersViewModel.getFeaturedPlayers()
            newsViewsModel.getaNewsData()
        }
    }
}
