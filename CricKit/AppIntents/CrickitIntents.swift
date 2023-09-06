//
//  CrickitIntents.swift
//  CricKit
//
//  Created by ephrim.daniel on 31/08/23.
//

import Foundation
import AppIntents
import SwiftUI
import FirebaseFirestore
import Firebase

struct GetLiveScoreIntent: AppIntent {
	static let title: LocalizedStringResource = "Get Live Score"

	func perform() async throws -> some ProvidesDialog & ShowsSnippetView {
		
		var liveScoreCardModel : LiveScoreCardModel?
		
        let result = try await GetLiveScoreForIntent.liveScore()
        liveScoreCardModel = result[0]
		
        return .result(dialog: "Okay, fetching live score", view: LiveScoreCardViewForIntent(liveScoreCardData: liveScoreCardModel!))
        //return .result(dialog: "Okay, fetching live score", view: LiveScoreCardView(liveScoreCardData: liveScoreCardModel!))
	}
}

struct GetLiveScoreForIntent {
    
    static func liveScore(configureFirebase: Bool = false) async throws-> [LiveScoreCardModel] {
        if configureFirebase {
            FirebaseApp.configure()
        }
        let db = Firestore.firestore()
        var liveScoreModel = [LiveScoreCardModel]()
        var teamStatusArray = [TeamStats]()
        
        do {
            let parentCollection = FSCollectionManager.getCollectionID(collection: .liveScore(subCollectionPath: .none))
            let snapshot = try await db.collection(parentCollection).getDocuments()
            for doc in snapshot.documents{
                let matchStatus = doc["matchStatus"] as? String ?? ""
                let matchHeader = doc["matchHeader"] as? String ?? ""
        
                let teamsStatusDocumentID = doc.documentID
                let subCollection = FSCollectionManager.getCollectionID(collection: .liveScore(subCollectionPath: .teamStatus))
                let snapshot = try await db.collection(parentCollection).document(teamsStatusDocumentID).collection(subCollection).getDocuments()
                teamStatusArray.removeAll()
                for doc in snapshot.documents {
                    let teamStats = TeamStats(name: doc["name"] as? String ?? "",
                                              flag: doc["flag"] as? String ?? "",
                                              overs: doc["overs"] as? String ?? "",
                                              runs: doc["runs"] as? String ?? "",
                                              wickets: doc["wickets"] as? String ?? "")
                    teamStatusArray.append(teamStats)
                }
                let liveScoreData = LiveScoreCardModel(matchStatus: matchStatus, matchHeader: matchHeader, isLive: true, TeamStatus:  teamStatusArray)
                liveScoreModel.append(liveScoreData)
            }
        } catch {
            print(error)
        }
        return liveScoreModel
    }
}



struct CrickitShortcuts: AppShortcutsProvider {
	static var appShortcuts: [AppShortcut] {
		AppShortcut(
			intent: GetLiveScoreIntent(),
			phrases: ["Get liveScore \(.applicationName)"]
		)
	}
}


struct LiveScoreCardViewForIntent: View {
    
    var liveScoreCardData : LiveScoreCardModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text(liveScoreCardData.matchHeader)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .opacity(0.8)
            ForEach(liveScoreCardData.TeamStatus) { team in
                HStack {
                    LiveTeamSummaryViewForIntent(team: team)
                }
            }
            HStack {
                if liveScoreCardData.isLive {
                    LiveDotViewForIntent()
                }
                Text(liveScoreCardData.matchStatus)
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
        }
        .padding()
    }
}


struct LiveTeamSummaryViewForIntent: View {
    let team: TeamStats
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Image(team.flag)
                .resizable()
                .frame(width: 35, height: 35)
            HStack(spacing: 5){
                Text(team.name)
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                Text(team.yetToBat() ? "" : "\(team.runs)/\(team.wickets)")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                Spacer()
                Text(team.yetToBat() ? team.yetToBatText() : "\(team.overs) overs")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
        }
    }
}

struct LiveDotViewForIntent: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
            Text("Live")
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
