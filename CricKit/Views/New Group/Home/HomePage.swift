//
//  HomePage.swift
//  CricKit
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI
import ActivityKit
import TipKit

struct HomePage: View {
    @State var selectedIndex = 0
    
    @ObservedObject var liveScoreCardViewModel = LiveScoreCardViewModel()
    @EnvironmentObject private var appSettings: AppSettings
    private let myTip = LiveScoreTip(imageName: "lasso.and.sparkles", header: "Adding Live acitvities", desc: "Sit back and Relax - please tap below cards to enable live activities")
	
    var body: some View {
        NavigationStack {
            ZStack {
                
                if appSettings.isDarkMode {
                    Color.appBlacks
                        .clipShape(BackgroundCard())
                } else {
                    Color.appWhites
                        .clipShape(BackgroundCard())
                }
                
                VStack(spacing: 0) {
					TipView(myTip, arrowEdge: .bottom)
						.padding()
                    AppLogoView()
						.task {
                            try? Tips.configure([
                                .datastoreLocation(.applicationDefault),
                                .displayFrequency(.immediate)
                            ])
						}
                    
                    switch selectedIndex {
                    case 0:
                        HomeBoard(liveScoreCardViewModel: liveScoreCardViewModel)
                    case 1:
						LiveMatches()
                    default:
                        UserProfilePage()
                    }
                    
                    VStack() {
                        HStack (alignment: .center, spacing: 30) {
                            customTabBar(selectedIndex: $selectedIndex)
                        }
                        .padding(.top, 16)
                        .padding(.bottom, -20)
                        
                    }
                    Spacer()
                }
            }.background(appSettings.isDarkMode ? Color.linearBlackColor : Color.linearWhiteColor)
                .navigationBarBackButtonHidden(true)
        }
    }
    init() {
        liveScoreCardViewModel.getLiveScore()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .environmentObject(AppSettings())
    }
}

struct HomeBoard: View {
    
    @StateObject var sectionProgress = HomeSection()
    @ObservedObject var liveScoreCardViewModel: LiveScoreCardViewModel
    
    @State private var activity : Activity<LiveScoreActivityAttributes>? = nil
    
    @EnvironmentObject private var appSettings: AppSettings
    
    var width = UIScreen.main.bounds.width
    @State private var alert: AlertTypes? = nil
    
    var body: some View {
        VStack{
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    if liveScoreCardViewModel.isLoading {
                        LiveScoreCardShimmerView(width: width - 32)
                            .offset(x: 16)
                    } else {
                        ForEach(Array(liveScoreCardViewModel.liveScoreCardlists.enumerated()), id: \.element.id) { index, liveScoreItem in
                            LiveScoreCardView(liveScoreCardData: liveScoreItem)
                                .frame(width: width - 32, height: 200)
                                .clipShape(LiveMatchCard())
                                .background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                                .clipShape(LiveMatchCard())
                                .cornerRadius(10, corners: .allCorners)
                                .padding(.trailing, index == liveScoreCardViewModel.liveScoreCardlists.count - 1 ? 30: 0)
                                .onTapGesture {
                                    // MARK: LIVE ACTIVITY
                                    let attributes = LiveScoreActivityAttributes(matchName: liveScoreItem.matchHeader)
                                    let state = LiveScoreActivityAttributes.ContentState(endTime: Date().addingTimeInterval(60), liveScoreModel: liveScoreItem)
                                    do {
                                        let orderActivity = try Activity.request(
                                            attributes: attributes,
                                            contentState: state,
                                            pushType: nil
                                        )
                                        alert = AlertTypes.defaulAlert(title: "Live Activity for \(liveScoreItem.matchHeader) is now added to your lock screen", message: "Please check your lock screen notifications")
                                        // TODO: Add push notification for live activity to update
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                        }
                        .offset(x: 16)
                    }
                    
                }
            }
            HomeSections(sectionProgress: sectionProgress)
                .frame(width: width)
                .padding(.top, 25)
                .padding(.bottom, 5)
            ScrollView(showsIndicators: false) {
                VStack(spacing: -20) {
                    HomeSectionSwitches(sectionProgress: sectionProgress)
                        .frame(width: UIScreen.main.bounds.width)
                }
                .padding(.bottom, 10)
            }
            .shadow(color: appSettings.isDarkMode ? Color.black : Color.white, radius: 0.5)
        }
        .alert(item: $alert) { value in
            return value.alert
        }
    }
}

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
                                    .clipShape(LiveMatchCard())
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
                                .clipShape(LiveMatchCard())
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
        .padding()
        .onAppear {
            recentMatchesViewModel.getRecentMatches()
            upComingMatchesViewModel.geUpComingMatches()
            featuredPlayersViewModel.getFeaturedPlayers()
            newsViewsModel.getaNewsData()
        }
    }
}
