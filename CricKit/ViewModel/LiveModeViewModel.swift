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
	
//	func isRecentBallPresent() -> Bool {
//		var value : Bool = false
//		if let recentBalls = self.liveModelForMatch?.recentBalls  {
//			value = (recentBalls.isEmpty)
//		}
//		print("<<< isRecentBallPresent \(value)")
//		return value
//	}
	
//	func isPlayer2ScorePresent() -> Bool {
//		var value : Bool = false
//		if let player2 = self.liveModelForMatch?.player2 , let player2Score = self.liveModelForMatch?.player2Score   {
//			value = ((player2.isEmpty) && (player2Score.isEmpty))
//		}
//		return !value
//	}
//	
//	func isPlayer1ScorePresent() -> Bool {
//		var value : Bool = false
//		if let player1 = self.liveModelForMatch?.player1, let player1Score = self.liveModelForMatch?.player1Score   {
//			value = ((player1.isEmpty) && (player1Score.isEmpty))
//		}
//		return !value
//	}
//	
//	func isTeamStatusPresent() -> Bool {
//		var value : Bool = false
//		if let teamFlag = self.liveModelForMatch?.teamFlag, let teamName = self.liveModelForMatch?.teamName{
//			value = ((teamFlag.isEmpty) && (teamName.isEmpty))
//		}
//		return !value
//	}
//	
//	func isTeamScorePresent() -> Bool {
//		var value : Bool = false
//		if let runs = self.liveModelForMatch?.runs, let wickets = self.liveModelForMatch?.wickets, let overs = self.liveModelForMatch?.wickets {
//			value = ((runs.isEmpty) && (wickets.isEmpty) && (overs.isEmpty))
//		}
//		return !value
//	}
//	
//	func isBowlerPresent() -> Bool {
//		var value : Bool = false
//		if let bowler = self.liveModelForMatch?.bowler, let bowlerStats = self.liveModelForMatch?.bowlerStats{
//			value = ((bowler.isEmpty) && (bowlerStats.isEmpty))
//		}
//		return !value
//	}
}
