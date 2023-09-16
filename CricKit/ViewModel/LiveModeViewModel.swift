//
//  LiveModeViewModel.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/09/23.
//

import Foundation

class LiveModeViewModel : ObservableObject {

    var liveModel = [LiveModeData]()
    @Published var liveModelForMatch : LiveModeData?

    func getLiveScore(for _MatchName: String = "") {
        print("<<< received MatchName \(_MatchName)")
        let parentCollection = FSCollectionManager.getCollectionID(collection: .liveMode)
        FbDataServiceManager.shared.getDataWithSnapShot(parentCollection: parentCollection) { [self] snapshot in
            if let documents = snapshot?.documents {
                self.liveModel.removeAll()
                self.liveModel = documents.compactMap { document in
                    let data = document.data()
                    let teamName = data["teamName"] as? String ?? ""
                    let teamFlag = data["teamFlag"] as? String ?? ""
                    let runs = data["runs"] as? String ?? ""
                    let wickets = data["wickets"] as? String ?? ""
                    let overs = data["overs"] as? String ?? ""
                    let crr = data["crr"] as? String ?? ""
                    let pship = data["pship"] as? String ?? ""
                    let player1 = data["player1"] as? String ?? ""
                    let player1Score = data["player1Score"] as? String ?? ""
                    let player2 = data["player2"] as? String ?? ""
                    let player2Score = data["player2Score"] as? String ?? ""
                    let bowler = data["bowler"] as? String ?? ""
                    let bowlerStats = data["bowlerStats"] as? String ?? ""
                    let recentBalls = data["recentBalls"] as? String ?? ""
                    let matchHeader = data["matchHeader"] as? String ?? ""
                    return LiveModeData(teamName: teamName, teamFlag: teamFlag, matchHeader: matchHeader, runs: runs, wickets: wickets, overs: overs, crr: crr, pship: pship, player1: player1, player1Score: player1Score, player2: player2, player2Score: player2Score, bowler: bowler, bowlerStats: bowlerStats, recentBalls: recentBalls)
                }
            }
            print("<<< liveModel \(liveModel)")

            for liveMatch in self.liveModel {
                if _MatchName == liveMatch.matchHeader {
                    self.liveModelForMatch = liveMatch
                }
            }

            print("<<< matched match \(String(describing: self.liveModelForMatch))")
        }
    }
}
