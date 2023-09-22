//
//  LiveScoreCardModel.swift
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


struct LiveScoreCardModel: Encodable, Decodable, Identifiable, Hashable {
    static func == (lhs: LiveScoreCardModel, rhs: LiveScoreCardModel) -> Bool {
        return lhs.id == rhs.id
    }
    var id = UUID()
    var matchStatus: String
    var matchHeader: String
    var isLive: Bool
    var TeamStatus : [TeamStats]
    
    enum CodingKeys: String, CodingKey {
        case matchStatus = "matchStatus"
        case matchHeader = "matchHeader"
        case isLive = "isLive"
        case TeamStatus = "TeamStatus"
    }
    
    
}

struct TeamStats: Encodable, Decodable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var flag: String
    var overs: String
    var runs: String
    var wickets: String
    var batsMen: NSArray = []
    var batsMenScore: NSArray = []
    var bowlers: NSArray = []
    var bStat: NSArray = []
    
    func yetToBat() -> Bool{
        return self.runs.isEmpty
    }
    
    func yetToBatText() -> String{
        return "Yet to Bat"
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case flag = "flag"
        case overs = "overs"
        case runs = "runs"
        case wickets = "wickets"
    }
}
