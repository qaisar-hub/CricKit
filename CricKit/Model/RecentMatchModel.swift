//
//  RecentMatchModel.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 26/08/23.
//

import Foundation

struct RecentMatchModel: Identifiable, Hashable {
    static func == (lhs: RecentMatchModel, rhs: RecentMatchModel) -> Bool {
        return lhs.id == rhs.id
    }
    var id = UUID()
    var matchStatus: String
    var TeamStatus : [TeamStats]
}

