//
//  HomeBoard.swift
//  CricKit
//
//  Created by Qaisar Raza on 19/09/23.
//

import SwiftUI
import ActivityKit
import TipKit

struct HomeBoard: View {
    
    @StateObject var sectionProgress = HomeSection()
    @ObservedObject var liveScoreCardViewModel: LiveScoreCardViewModel
    
    @State private var activity : Activity<LiveScoreActivityAttributes>? = nil
    
    @EnvironmentObject private var appSettings: AppSettings
    
    var width = UIScreen.main.bounds.width
    @State private var alert: AlertTypes? = nil
    
    private let liveScoreTip = LiveScoreTip(imageName: "lasso.and.sparkles", header: "Adding Live acitvities", desc: "Sit back and Relax - please tap below cards to enable live activities")
    
    var body: some View {
        VStack{
            TipView(liveScoreTip, arrowEdge: .bottom)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    if liveScoreCardViewModel.isLoading {
                        LiveScoreCardShimmerView(width: width - 50)
                            .offset(x: 16)
                    } else {
                        ForEach(Array(liveScoreCardViewModel.liveScoreCardlists.enumerated()), id: \.element.id) { index, liveScoreItem in
                            LiveScoreCardView(liveScoreCardData: liveScoreItem)
                                .frame(width: width - 50, height: 200)
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
                                        let _ = try Activity.request(
                                            attributes: attributes,
                                            content: .init(state: state, staleDate: nil),
                                            pushType: nil
                                        )
                                        alert = AlertTypes.defaulAlert(title: "Live Activity for \(liveScoreItem.matchHeader) is now added to your lock screen", message: "Please check your lock screen notifications")
                                        // TODO: Add push notification for live activity to update
                                        liveScoreTip.invalidate(reason: .actionPerformed)
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                        }
                        .offset(x: 16)
                    }
                    
                }
            }
            .task {
                try? Tips.configure([
                    .datastoreLocation(.applicationDefault),
                    .displayFrequency(.immediate)
                ])
            }
            HomeSections(sectionProgress: sectionProgress)
                .frame(width: width)
                .padding(.top, 25)
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
