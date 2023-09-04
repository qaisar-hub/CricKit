//
//  LiveScoreCardEntry.swift
//  WidgetCrickitExtension
//
//  Created by  Ephrim Daniel J on 04/09/23.
//
import Foundation
import WidgetKit

struct LiveScoreCardEntry: TimelineEntry {
    let date: Date
    let liveScoreCardModel: LiveScoreCardModel
    
    // used to display the placeholder data while adding the widget to the view
    static func mockLiveScoreCardEntry() -> LiveScoreCardModel  {
        let leftTeam = TeamStats(name: "IND", flag: "teamInd", overs: "50", runs: "280", wickets: "6")
        let rightTeam = TeamStats(name: "AUS", flag: "teamAus", overs: "40", runs: "180", wickets: "5")
        
        let liveScoreCardModel = LiveScoreCardModel(matchStatus: "Aus Need 100 runs to win", matchHeader: "ICC WC 2023, Ind vs Aus | Delhi", isLive: true, TeamStatus: [leftTeam, rightTeam])
        return liveScoreCardModel
    }
}
