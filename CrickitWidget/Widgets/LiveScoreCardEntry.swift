//
//  LiveScoreCardEntry.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import Foundation
import WidgetKit
import Firebase

struct LiveScoreCardEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let liveScoreCardModel: LiveScoreCardModel
    
    static func mockLiveScoreCardEntry() -> LiveScoreCardModel  {
        let leftTeam = TeamStats(name: "IND", flag: "teamInd", overs: "50", runs: "280", wickets: "6")
        let rightTeam = TeamStats(name: "AUS", flag: "teamAus", overs: "40", runs: "180", wickets: "5")
        
        let liveScoreCardModel = LiveScoreCardModel(matchStatus: "Aus Need 100 runs to win", matchHeader: "ICC WC 2023, Ind vs Aus | Delhi", isLive: true, TeamStatus: [leftTeam, rightTeam])
        return liveScoreCardModel
    }
    
    static func getLiveScoreCardEntry() async -> LiveScoreCardModel {
        var liveScoreCardModel : LiveScoreCardModel!
        do {
            let result = try await GetLiveScoreForIntent.liveScore()
            liveScoreCardModel = result[0]
        }  catch {
            print(error)
        }
        return liveScoreCardModel
    }
}

