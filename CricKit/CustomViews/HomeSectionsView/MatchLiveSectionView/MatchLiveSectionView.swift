//
//  MatchLiveSectionView.swift
//  CricKit
//
//  Created by Qaisar Raza on 14/08/23.
//

import SwiftUI

struct MatchSummaryView: View {
    let leftTeam: Team
    let rightTeam: Team
    let isLive: Bool
    
    var body: some View {
        VStack {
            Text("1st ODI . India tour for Australia , 2023")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            TeamSummaryView(team: leftTeam)
            TeamSummaryView(team: rightTeam)
            
            HStack {
                if isLive {
                    LiveDotView()
                }
                Text("India won by 100 runs")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
        }.padding()
    }
}

struct LiveDotView: View {
    var body: some View {
        HStack {
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
            Text("Live")
                .font(.subheadline)
                .foregroundColor(Color.appSecondary)
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.appBlacks.opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


struct TeamSummaryView: View {
    let team: Team
    
    var body: some View {
        HStack {
            Image(team.flagImageName)
                .resizable()
                .frame(width: 35, height: 35)
            
            HStack(spacing: 5){
                Text(team.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.white)
                
                Text("\(team.runs)/\(team.wickets)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Text("\(team.overs) overs")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
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

struct MatchLiveSectionView: View {
    let leftTeam = Team(name: "IND", flagImageName: "teamInd", runs: 280, wickets: 6, overs: 50)
    let rightTeam = Team(name: "AUS", flagImageName: "teamAus", runs: 180, wickets: 5, overs: 40)
    let isLive = true
    
    var body: some View {
        VStack{
            MatchSummaryView(leftTeam: leftTeam, rightTeam: rightTeam, isLive: isLive)
        }
    }
}


struct MatchSummaryView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let leftTeam = Team(name: "IND", flagImageName: "teamInd", runs: 280, wickets: 6, overs: 50)
        let rightTeam = Team(name: "AUS", flagImageName: "teamAus", runs: 180, wickets: 5, overs: 40
        )
        MatchSummaryView(leftTeam: leftTeam, rightTeam: rightTeam, isLive: true)
    }
}

