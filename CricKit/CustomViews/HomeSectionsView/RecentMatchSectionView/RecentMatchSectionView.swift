//
//  RecentMatchSectionView.swift
//  CricKit
//
//  Created by ephrim.daniel on 14/08/23.
//

import SwiftUI

struct RecentMatchSectionView: View {
    let leftTeam = Team(name: "IND", flagImageName: "teamInd", runs: 280, wickets: 6, overs: 50)
    let rightTeam = Team(name: "AUS", flagImageName: "teamAus", runs: 180, wickets: 5, overs: 40)
    
    
    var body: some View {
        HStack{
            MatchSummarySection(leftTeam: leftTeam, rightTeam: rightTeam, isLive: false)
        }
        .cornerRadius(25, corners: .allCorners)
        .background(Blur(style: .systemChromeMaterialDark))
        .clipShape(LiveMatchCard())
    }
}


struct MatchSummarySection: View {
    let leftTeam: Team
    let rightTeam: Team
    let isLive: Bool
    
    var body: some View {
        VStack {
            HStack {
                TeamSummarySectionView(team: leftTeam)
                Spacer()
            }
            HStack {
                Spacer()
                Text("VS")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Spacer()
            }
            HStack {
                Spacer()
                TeamSummarySectionView(team: rightTeam)
            }
            HStack {
                VStack {
                    Text("India won by 100 runs")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
                Spacer()
            }
            
        }.padding()
    }
}

struct TeamSummarySectionView: View {
    let team: Team
    
    var body: some View {
        HStack {
            Image(team.flagImageName)
                .resizable()
                .frame(width: 35, height: 35)
            HStack{
                Text(team.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.white)
                
                Text("\(team.runs)/\(team.wickets)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                
                Text("\(team.overs) overs")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
        }
    }
}


struct PlayerOfTheMatchView: View {
    var body: some View {
            Text("MOM: Virat Kohli")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(Color.appWhites)
        Image("playerVirat")
            .resizable()
            .frame(width: 30, height: 30)
            .clipShape(Circle())
    }
}
