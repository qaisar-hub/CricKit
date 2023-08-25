//
//  LiveScoreCardView.swift
//  CricKit
//
//  Created by Qaisar Raza on 14/08/23.
//

import SwiftUI

struct LiveScoreCardView: View {
    
    var liveScoreCardData : LiveScoreCardData
    
    var body: some View {
        VStack {
            Text(liveScoreCardData.matchHeader)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            ForEach(liveScoreCardData.TeamStatus) { team in
                HStack {
                    LiveTeamSummaryView(team: team)
                }
            }
            HStack {
                if liveScoreCardData.isLive {
                    LiveDotView()
                }
                Text(liveScoreCardData.matchStatus)
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


struct LiveTeamSummaryView: View {
    let team: TeamStats
    
    var body: some View {
        HStack {
            Image(team.flag)
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



