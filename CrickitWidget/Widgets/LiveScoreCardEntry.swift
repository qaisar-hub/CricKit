//
//  LiveScoreCardEntry.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import Foundation
import WidgetKit

struct LiveScoreCardEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let liveScoreCard: LiveScoreCard
    
    static func mockLiveScoreCardEntry() -> LiveScoreCard  {
        let leftTeam = LiveScore(name: "IND", flagImageName: "teamInd", runs: 280, wickets: 6, overs: 50)
        let rightTeam = LiveScore(name: "AUS", flagImageName: "teamAus", runs: 180, wickets: 5, overs: 40)
        let liveScoreCard = LiveScoreCard(matchName: "India vs Australia", matchStatus: "India Won by 100 Runs", playerOfTheMatch: "Virat", liveScore: [leftTeam, rightTeam])
        return liveScoreCard
    }
}

