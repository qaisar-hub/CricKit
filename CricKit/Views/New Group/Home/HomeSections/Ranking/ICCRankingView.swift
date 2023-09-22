//
//  ICCRankingView.swift
//  swiftuisample
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI

struct ICCRankingView: View {
    @ObservedObject var rankingViewModel = RankingViewModel()
    @EnvironmentObject private var appSettings: AppSettings
    var selectedTab: TabSelection
    var rankingArray: [Ranking]
    
    var sectionHeader: String {
            switch selectedTab {
            case .batsman:
                return "Player Rankings"
            case .bowler:
                return "Bowler Rankings"
            case .allRounder:
                return "All Rounder Rankings"
            case .team:
                return "Team Rankings"
            }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: HeaderView(title: sectionHeader, rightText: "Rating")) {
                    ForEach(0..<10) { index in
                        let rank = selectedTab != .team ? rankingArray[index].rank : rankingArray[index].rank
                        let symbolName = selectedTab != .team ? "person.crop.circle.fill" : "square.fill"
                        let title = selectedTab != .team ? rankingArray[index].player : rankingArray[index].team
                        let subtitle = selectedTab != .team ? rankingArray[index].team : "Points: \(rankingArray[index].points ?? 0)"
                        let rating = selectedTab != .team ? rankingArray[index].rating : rankingArray[index].rating
                        RankingEntryView(rank: rank ?? 0,
                                         rating: rating ?? 0,
                                         symbolName: symbolName,
                                         title: title ?? "",
                                         subtitle: subtitle ?? "")
                    }
                }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
            }
        }
    }
}

struct HeaderView: View {
    @EnvironmentObject private var appSettings: AppSettings
    var title: String
    var rightText: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            Spacer()
            Text(rightText)
                .font(.caption)
                .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                .fontWeight(.medium)
        }
    }
}



struct RankingEntryView: View {
    var rank: Int
    var rating: Int
    var symbolName: String
    var title: String
    var subtitle: String
    @EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        HStack(spacing: 20) {
            Text("\(rank)")
                .font(.headline)
                .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            Image(systemName: symbolName)
                .resizable()
                .foregroundStyle(.gray)
                .frame(width: 30, height: 30)
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                }
                Spacer()
                Text("\(rating)")
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                    .font(.subheadline)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}


struct ICCRankingView_Previews: PreviewProvider {
    static var previews: some View {
        ICCRankingView(selectedTab: .batsman, rankingArray: [])
    }
}
