//
//  LiveScoreCardViewModel.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 23/08/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class LiveScoreCardViewModel : ObservableObject {
    
    @Published var liveScoreCardlists = [LiveScoreCardData]()
    
    var teamStats : TeamStats? = nil
    var teamStatusArray = [TeamStats]()
    
    func getLiveScore() {
        FbDataServiceManager.shared.getData(parentCollection: liveScoreCollectionPath()) { [self] snapshot in
            if let snapshot = snapshot {
                self.liveScoreCardlists.removeAll()
                for doc in snapshot.documents{
                    let matchStatus = doc["matchStatus"] as? String ?? ""
                    let matchHeader = doc["matchHeader"] as? String ?? ""
                    let isLive = doc["isLive"] as? Bool ?? true
                    let teamsStatusDocumentID = doc.documentID
                    // accessing firestore sub-collection from document ID of parent Collection
                    FbDataServiceManager.shared.getDataWithDocumentID(parentCollection: liveScoreCollectionPath(), documentId: teamsStatusDocumentID, subCollection: teamStatusCollectionPath()) { snapshot in
                        if let snapshot = snapshot {
                            print("<<< event 2")
                            self.teamStatusArray.removeAll()
                            for doc in snapshot.documents {
                                let teamStats = TeamStats(name: doc["name"] as? String ?? "",
                                                          flag: doc["flag"] as? String ?? "",
                                                          overs: doc["overs"] as? String ?? "",
                                                          runs: doc["runs"] as? String ?? "",
                                                          wickets: doc["wickets"] as? String ?? "")
                                self.teamStatusArray.append(teamStats)
                            }
                            let liveScoreData = LiveScoreCardData(matchStatus: matchStatus, matchHeader: matchHeader, isLive: isLive, TeamStatus:  self.teamStatusArray)
                            self.liveScoreCardlists.append(liveScoreData)
                        }
                    }
                }
            }
        }
    }
    
    private func liveScoreCollectionPath() -> String {
        return FireStoreHelper.getCollectionID(collection: FireStoreCollection.liveScore(subCollectionPath: .none))
    }
    
    private func teamStatusCollectionPath() -> String {
        return FireStoreHelper.getCollectionID(collection: FireStoreCollection.liveScore(subCollectionPath: .teamStatus))
    }
}


