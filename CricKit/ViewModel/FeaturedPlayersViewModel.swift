//
//  FeaturedPlayersViewModel.swift
//  CricKit
//
//  Created by ephrim.daniel on 28/08/23.
//

import Foundation


class FeaturedPlayersViewModel : ObservableObject {
    
    @Published var featuredPlayers = [FeaturedPlayersModel]()
    
    func getFeaturedPlayers() {
        let parentCollection = FSCollectionManager.getCollectionID(collection: .featuredPlayers)
        FbDataServiceManager.shared.getData(parentCollection: parentCollection) { [self] snapshot in
            if let snapshot = snapshot {
                self.featuredPlayers.removeAll()
                for doc in snapshot.documents{
                    let playerName = doc["name"] as? String ?? ""
                    let featuredPlayer = FeaturedPlayersModel(name: playerName)
                    self.featuredPlayers.append(featuredPlayer)
                    print("<<< featuredPlayers \(self.featuredPlayers)")
                }
            }
        }
    }
}
