//
//  LiveScoreCard.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import Foundation


/* struct Team LiveScoreCard LiveScore Not in use but used in other places for mock data
 need to remove after server data integration */
struct Team {
    let name: String
    let flagImageName: String
    let runs: Int
    let wickets: Int
    let overs: Int
}

struct LiveScoreCard: Identifiable, Decodable, Hashable {
    var id = UUID()
    let matchName: String
    let matchStatus: String
    let playerOfTheMatch: String
    let liveScore: [LiveScore]
}

struct LiveScore: Identifiable, Decodable, Hashable {
    var id = UUID()
    let name: String
    let flagImageName: String
    let runs: Int
    let wickets: Int
    let overs: Int
}


struct LiveScoreCardData: Identifiable, Hashable {
    static func == (lhs: LiveScoreCardData, rhs: LiveScoreCardData) -> Bool {
        return lhs.id == rhs.id
    }
    var id = UUID()
    var matchStatus: String
    var matchHeader: String
    var isLive: Bool
    var TeamStatus : [TeamStats]
}

struct TeamStats: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var flag: String
    var overs: String
    var runs: String
    var wickets: String
}
