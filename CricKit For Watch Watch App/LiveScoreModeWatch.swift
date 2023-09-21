//
//  LiveScoreModeWatch.swift
//  CricKit For Watch Watch App
//
//  Created by gokul.krishnan on 18/09/23.
//

import Foundation
struct Documents: Codable {
    var documents: [Document]
}
struct Document: Codable {
    
    
    var name: String
    var fields: Matches
    var createTime: String
    var updateTime: String
}
struct Matches: Codable {
    
    
    var bowler : Bowler
    var bowlerStats: BowlerStats
    var crr: Crr
    var matchHeader: MatchHeader
    var overs: Overs
    var player1: Player1
    var player1Score: Player1Score
    var player2: Player2
    var player2Score: Player2Score
    var pship: Pship
    var recentBalls: RecentBalls
    var runs: Runs
    var teamFlag: TeamFlag
    var teamName: TeamName
    var wickets: Wickets
}
struct Bowler: Codable {
    
    
    var stringValue : String
}
struct BowlerStats: Codable {
    
    var stringValue : String
}
struct Crr: Codable {
    
    var stringValue : String
}
struct MatchHeader: Codable {
    
    var stringValue : String
}
struct Overs: Codable {
    
    var stringValue : String
}
struct Player1: Codable {
    
    var stringValue : String
}
struct Player1Score: Codable {
    
    var stringValue : String
}
struct Player2: Codable {
    
    var stringValue : String
}
struct Player2Score: Codable {
    
    var stringValue : String
}
struct Pship: Codable {
    
    var stringValue : String
}
struct RecentBalls: Codable {
    
    var stringValue : String
}
struct Runs: Codable {
    
    var stringValue : String
}
struct TeamFlag: Codable {
    
    var stringValue : String
}
struct TeamName: Codable {
    
    var stringValue : String
}
struct Wickets: Codable {
    
    var stringValue : String
}
