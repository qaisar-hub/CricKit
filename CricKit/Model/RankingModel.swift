//
//  RankingModel.swift
//  CricKit
//
//  Created by Qaisar Raza on 22/09/23.
//

import Foundation

struct RankingResponse: Codable {
    var category: RankingCategory
}

struct RankingCategory: Codable {
    var teams: [Ranking]
    var batsman: [Ranking]
    var bowling: [Ranking]
    var allRounder: [Ranking]
}

struct Ranking: Codable {
    var rank: Int?
    var player: String?
    var team: String?
    var rating: Int?
    var points: Int?
    var matches: Int?
    var careerBestRating: String?
}
