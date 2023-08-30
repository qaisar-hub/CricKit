//
//  RecentMatchView.swift
//  CricKit
//
//  Created by ephrim.daniel on 14/08/23.
//

import SwiftUI


struct RecentMatchView: View {
    
    var recentMatchModel : RecentMatchModel
    
    var body: some View {
        VStack {
            ForEach(0..<recentMatchModel.TeamStatus.count) { index in
                HStack {
                    
                    if (index == 0){
                        TeamSummarySectionView(team: recentMatchModel.TeamStatus[index])
                            .padding(.horizontal, 5)
                        Spacer()
                    } else {
                        Spacer()
                        TeamSummarySectionView(team: recentMatchModel.TeamStatus[index])
                            .padding(.horizontal, 5)
                    }
                    
                }
            }
            HStack {
                Text(recentMatchModel.matchStatus)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.leading, 5)
                Spacer()
            }
        }
        .padding()
    }
}

struct TeamSummarySectionView: View {
    let team: TeamStats
    
    var body: some View {
        HStack {
            Image(team.flag)
                .resizable()
                .frame(width: 25, height: 25)
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
