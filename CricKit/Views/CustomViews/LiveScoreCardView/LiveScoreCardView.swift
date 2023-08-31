//
//  LiveScoreCardView.swift
//  CricKit
//
//  Created by Qaisar Raza on 14/08/23.
//

import SwiftUI
import Shimmer

struct LiveScoreCardView: View {
    
    var liveScoreCardData : LiveScoreCardModel
	@EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        VStack {
            Text(liveScoreCardData.matchHeader)
				.font(.subheadline)
				.fontWeight(.medium)
				.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                .opacity(0.8)
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
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            }
        }.padding()
    }
}

struct LiveDotView: View {
	@EnvironmentObject private var appSettings: AppSettings
	
    var body: some View {
        HStack {
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
            Text("Live")
				.font(.subheadline)
				.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            
        }
        .shimmering(bandSize: 10)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
		.background( appSettings.isDarkMode ? Color.black.opacity(0.8) : Color.white.opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


struct LiveTeamSummaryView: View {
    let team: TeamStats
	@EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        HStack {
            Image(team.flag)
                .resizable()
                .frame(width: 35, height: 35)
            HStack(spacing: 5){
                Text(team.name)
                    .font(.subheadline)
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                Text(team.yetToBat() ? "" : "\(team.runs)/\(team.wickets)")
					.font(.subheadline)
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                Spacer()
                Text(team.yetToBat() ? team.yetToBatText() : "\(team.overs) overs")
					.font(.subheadline)
					.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            }
            
        }
    }
}



