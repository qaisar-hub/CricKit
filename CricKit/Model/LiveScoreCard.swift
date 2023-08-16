//
//  LiveScoreCard.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import Foundation

struct LiveScoreCard {
    let matchName: String
    let matchStatus: String
    let playerOfTheMatch: String
    let liveScore: [LiveScore]
    
    
    static func mockLiveScoreCardEntry() -> LiveScoreCard  {
        let leftTeam = LiveScore(name: "IND", flagImageName: "teamInd", runs: 280, wickets: 6, overs: 50)
        let rightTeam = LiveScore(name: "AUS", flagImageName: "teamAus", runs: 180, wickets: 5, overs: 40)
        var liveScoreCard = LiveScoreCard(matchName: "India vs Australia", matchStatus: "India Won by 100 Runs", playerOfTheMatch: "Virat", liveScore: [leftTeam, rightTeam])
        return liveScoreCard
    }
}

struct LiveScore {
    let name: String
    let flagImageName: String
    let runs: Int
    let wickets: Int
    let overs: Int
}
                              
