//
//  ICCRankingView.swift
//  swiftuisample
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI

struct ICCRankingView: View {
    @ObservedObject var rankingViewModel = RankingViewModel()
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
                Section(header: Text(sectionHeader)) { 
                    ForEach(0..<10) { index in
                        let rank = selectedTab != .team ? rankingArray[index].rank : rankingArray[index].rank
                        let symbolName = selectedTab != .team ? "person.crop.circle.fill" : "square.fill"
                        let title = selectedTab != .team ? rankingArray[index].player : rankingArray[index].team
                        let subtitle = selectedTab != .team ? rankingArray[index].team : "Points: \(rankingArray[index].points ?? 0)"
                        let rating = selectedTab != .team ? rankingArray[index].rating : rankingArray[index].rating
                        let detail = selectedTab != .team ? rankingArray[index].careerBestRating : ""
                        RankingEntryView(rank: rank ?? 0,
                                         rating: rating ?? 0,
                                         symbolName: symbolName,
                                         title: title ?? "",
                                         subtitle: subtitle ?? "")
                    }
                }
            }
        }
    }
}



struct RankingEntryView: View {
    var rank: Int
    var rating: Int
    var symbolName: String
    var title: String
    var subtitle: String
    
    var body: some View {
        HStack(spacing: 20) {
            Text("\(rank)")
                .font(.headline)
            Image(systemName: symbolName)
                .resizable()
                .frame(width: 30, height: 30)
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.subheadline)
                }
                Spacer()
                Text("\(rating)")
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
