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
    
    @Published var lists = [LiveScoreData]()
    
    var teamStats : TeamStats? = nil
    
    var teamStatusArray = [TeamStats]()
    
    func getLiveScores(){
        // MARK: Creating Firestore Data Base Reference
        let db = Firestore.firestore()
        
        // accessing firestore collection
        // addSnapshotListener - is to look for real time changes
        db.collection("liveScore").addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    
                    for doc in snapshot.documents{
                        let matchStatus = doc["matchStatus"] as! String
                        let teamA = doc.documentID
                        // accessing firestore sub-collection from document ID of parent Collection
                        db.collection("liveScore").document(teamA).collection("teamStatus").addSnapshotListener { snapshot, error in
                            if let snapshot = snapshot {
                                for doc in snapshot.documents {
                                    let teamStats = TeamStats(name: doc["name"] as? String ?? "")
                                    self.teamStatusArray.append(teamStats)
                                }
                                print("<<< teamStatusArray \(self.teamStatusArray)")
                                
                                let liveScoreData = LiveScoreData(matchStatus: matchStatus, TeamStatus:  self.teamStatusArray)
                                self.lists.append(liveScoreData)
                                print("<<< Final Lists \(self.lists)")
                            }
                        }
                    }
                }
                
            } else{
                
            }
        }
    }
}

struct LiveScoreData {
    var matchStatus: String
    var TeamStatus : [TeamStats]
}

struct TeamStats {
    var name: String
}
