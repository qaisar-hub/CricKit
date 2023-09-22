//
//  RecentMatchView.swift
//  CricKit
//
//  Created by ephrim.daniel on 14/08/23.
//

import SwiftUI


struct RecentMatchView: View {
    
    var recentMatchModel : RecentMatchModel
	@EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        VStack {
            ForEach(0..<recentMatchModel.TeamStatus.count, id: \.self) { index in
                HStack {
                    if (index == 0){
                        NavigationLink(destination: RecentMatchSummary(teamStat: recentMatchModel.TeamStatus,result: recentMatchModel.matchStatus)) {
                            TeamSummarySectionView(team: recentMatchModel.TeamStatus[index])
                                .padding(.horizontal, 5)
                        }
                        Spacer()
                    } else {
                        Spacer()
                        NavigationLink(destination: RecentMatchSummary(teamStat: recentMatchModel.TeamStatus,result: recentMatchModel.matchStatus)) {
                            TeamSummarySectionView(team: recentMatchModel.TeamStatus[index])
                                .padding(.horizontal, 5)
                        }
                    }
                    
                }
            }
            HStack {
                Text(recentMatchModel.matchStatus)
					.font(.subheadline)
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                    .padding(.leading, 5)
                Spacer()
            }
        }
        .padding()
    }
}

struct TeamSummarySectionView: View {
    let team: TeamStats
	@EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        HStack {
            Image(team.flag)
                .resizable()
                .frame(width: 25, height: 25)
            HStack{
                Text(team.name)
					.font(.subheadline)
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                Text("\(team.runs)/\(team.wickets)")
					.font(.subheadline)
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                
                Text("\(team.overs) overs")
					.font(.subheadline)
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
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
