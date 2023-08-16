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
}

struct LiveScore {
    let name: String
    let flagImageName: String
    let runs: Int
    let wickets: Int
    let overs: Int
}
                              
