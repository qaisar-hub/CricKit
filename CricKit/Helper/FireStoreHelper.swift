//
//  FireStoreHelper.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 25/08/23.
//

import Foundation

public class FSCollectionManager {
    
    static func getCollectionID(collection: parentCollection) -> String {
        switch collection{
        case .users:
            return "users"
        case .liveScore(subCollectionPath: let subCollectionPath):
            return subCollectionPath.value.path
        case .recentMatches(subCollectionPath: let subCollectionPath):
            return subCollectionPath.value.path
        case .featuredPlayers:
            return "featuredPlayers"
        case .upComingMatches(subCollectionPath: let subCollectionPath):
            return subCollectionPath.value.path
        case .news:
            return "news"
		case .liveMode:
			return "liveMode"
        }
    }
    
    enum parentCollection {
        case users
        case liveScore(subCollectionPath: liveScoreSubCollection)
        case recentMatches(subCollectionPath: recentMatchesSubCollection)
        case upComingMatches(subCollectionPath: upComingMatchesSubCollection)
        case featuredPlayers
        case news
		case liveMode
        
        enum liveScoreSubCollection {
            case teamStatus // returns liveScore -> teamStatus
            case none //none denotes that parent collection doesn't have any subCollection and hence we have "none" case which returns collectionId as "liveScore"
            struct Path {
                let path: String
            }
            var value: Path {
                switch self{
                case .teamStatus:
                    return Path(path: "teamStatus")
                case .none:
                    return Path(path: "liveScore")
                }
            }
        }
        
        enum recentMatchesSubCollection {
            case teamStatus
            case none
            struct Path {
                let path: String
            }
            var value: Path {
                switch self{
                case .teamStatus:
                    return Path(path: "teamStatus")
                case .none:
                    return Path(path: "recentMatches")
                }
            }
        }
        
        enum upComingMatchesSubCollection {
            case teamStatus
            case none
            struct Path {
                let path: String
            }
            var value: Path {
                switch self{
                case .teamStatus:
                    return Path(path: "teamStatus")
                case .none:
                    return Path(path: "upComingMatches")
                }
            }
        }
    }
}


