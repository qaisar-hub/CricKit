//
//  FireStoreHelper.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 25/08/23.
//

import Foundation

class FireStoreHelper : NSObject {
    static func getCollectionID(collection: FireStoreCollection) -> String {
        switch collection {
        case .user:
            return "user"
        case .liveScore(subCollectionPath: let subCollectionPath):
            switch subCollectionPath {
            case .teamStatus:
                return "teamStatus"
            case .none:
                return "liveScore"
            }
        }
    }
}


enum FireStoreCollection {
    case user
    case liveScore (subCollectionPath: FireStoreSubCollection?)
}

enum FireStoreSubCollection {
    case teamStatus
}
