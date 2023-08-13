//
//  MatchSummaryView.swift
//  CricKit
//
//  Created by Qaisar Raza on 14/08/23.
//

import SwiftUI

struct MatchSummaryView: View {
    let leftTeam: Team
    let rightTeam: Team
    
    var body: some View {
        HStack {
            TeamSummaryView(team: leftTeam)
                .padding(.trailing, 20)
            Text("VS")
                .font(.headline)
                .fontWeight(.bold)
                .fontWidth(.expanded)
            TeamSummaryView(team: rightTeam)
                .padding(.leading, 20)
        }
    }
}

struct TeamSummaryView: View {
    let team: Team
    
    var body: some View {
        VStack {
            Image(team.flagImageName)
                .resizable()
                .frame(width: 50, height: 50)
            
            VStack(spacing: 5){
                Text(team.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .fontWidth(.expanded)
                    .foregroundStyle(.black)
                
                Text("\(team.runs)/\(team.wickets)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
                
                Text("(\(team.overs) overs)")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
            }
            
        }
    }
}

struct Team {
    let name: String
    let flagImageName: String
    let runs: Int
    let wickets: Int
    let overs: Int
}

struct MatchSummarySectionView: View {
    let leftTeam = Team(name: "IND", flagImageName: "TeamIndia", runs: 280, wickets: 6, overs: 50)
    let rightTeam = Team(name: "AUS", flagImageName: "TeamAustralia", runs: 180, wickets: 5, overs: 40)
    
    var body: some View {
        MatchSummaryView(leftTeam: leftTeam, rightTeam: rightTeam)
    }
}
