//
//  RecentMatchesViewModel.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 26/08/23.
//

import Foundation
import SwiftUI

class RecentMatchesViewModel : ObservableObject {
    
    @Published var recentMatches = [RecentMatchModel]()
    @Published var isLoading = false
    
    var teamStats : TeamStats? = nil
    var teamStatusArray = [TeamStats]()
    
    func getRecentMatches() {
        self.isLoading = true
        let parentCollection = FSCollectionManager.getCollectionID(collection: .recentMatches(subCollectionPath: .none))
            FbDataServiceManager.shared.getData(parentCollection: parentCollection) { [self] snapshot in
            if let snapshot = snapshot {
                self.recentMatches.removeAll()
                var pendingOperations = snapshot.documents.count
                var tempLiveScoreCardlists = [RecentMatchModel]()
                for doc in snapshot.documents{
                    let matchStatus = doc["matchStatus"] as? String ?? ""
                    let teamsStatusDocumentID = doc.documentID
                    // accessing firestore sub-collection from document ID of parent Collection
                    let subCollection = FSCollectionManager.getCollectionID(collection: .recentMatches(subCollectionPath: .teamStatus))
                    FbDataServiceManager.shared.getDataWithDocumentID(parentCollection: parentCollection, documentId: teamsStatusDocumentID, subCollection: subCollection) { snapshot in
                        if let snapshot = snapshot {
                            self.teamStatusArray.removeAll()
                            for doc in snapshot.documents {
                                let teamStats = TeamStats(name: doc["name"] as? String ?? "",
                                                          flag: doc["flag"] as? String ?? "",
                                                          overs: doc["overs"] as? String ?? "",
                                                          runs: doc["runs"] as? String ?? "",
                                                          wickets: doc["wickets"] as? String ?? "")
                                self.teamStatusArray.append(teamStats)
                            }
                            let recentMatch = RecentMatchModel(matchStatus: matchStatus, TeamStatus: self.teamStatusArray)
                            tempLiveScoreCardlists.append(recentMatch)
                            pendingOperations -= 1
                            if (pendingOperations == 0) {
                                self.recentMatches = tempLiveScoreCardlists
                                self.isLoading = false
                            }
                        }
                    }
                }
            }
        }
    }
}


