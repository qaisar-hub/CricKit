//
//  UpComingMatchesModel.swift
//  CricKit
//
//  Created by ephrim.daniel on 28/08/23.
//

import Foundation

struct UpComingMatchModel: Identifiable, Hashable {
    static func == (lhs: UpComingMatchModel, rhs: UpComingMatchModel) -> Bool {
        return lhs.id == rhs.id
    }
    var id = UUID()
    var matchName: String
    var matchDetails: String
    var TeamStatus : [UpComingMatchStats]
}

struct UpComingMatchStats: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var flag: String
}
