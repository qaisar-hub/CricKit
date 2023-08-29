//
//  UpComingMatchViewModel.swift
//  CricKit
//
//  Created by ephrim.daniel on 28/08/23.
//

import Foundation

class UpComingMatchViewModel : ObservableObject {
    
    @Published var upComingMatches = [UpComingMatchModel]()
    
    var teamStats : TeamStats? = nil
    var matchStatusArray = [UpComingMatchStats]()
    
    func geUpComingMatches() {
        let parentCollection = FSCollectionManager.getCollectionID(collection: .upComingMatches(subCollectionPath: .none))
        FbDataServiceManager.shared.getData(parentCollection: parentCollection) { [self] snapshot in
            if let snapshot = snapshot {
                self.upComingMatches.removeAll()
                for doc in snapshot.documents{
                    let matchName = doc["matchName"] as? String ?? ""
                    let matchDetails = doc["matchDetails"] as? String ?? ""
                    let teamsStatusDocumentID = doc.documentID
                    // accessing firestore sub-collection from document ID of parent Collection
                    let subCollection = FSCollectionManager.getCollectionID(collection: .upComingMatches(subCollectionPath: .teamStatus))
                    FbDataServiceManager.shared.getDataWithDocumentID(parentCollection: parentCollection, documentId: teamsStatusDocumentID, subCollection: subCollection) { snapshot in
                        if let snapshot = snapshot {
                            self.matchStatusArray.removeAll()
                            for doc in snapshot.documents {
                                let teamStats = UpComingMatchStats(name: doc["name"] as? String ?? "",
                                                                   flag: doc["flag"] as? String ?? "")
                                self.matchStatusArray.append(teamStats)
                            }
                            let upComingMatch = UpComingMatchModel(matchName: matchName, matchDetails: matchDetails, TeamStatus: self.matchStatusArray)
                            self.upComingMatches.append(upComingMatch)
                        }
                    }
                }
            }
        }
    }
}


