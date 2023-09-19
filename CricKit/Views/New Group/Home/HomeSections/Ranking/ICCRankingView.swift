//
//  ICCRankingView.swift
//  swiftuisample
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI

import SwiftUI

struct ICCRankingView: View {
    var selectedTab: TabSelection
    
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
                Section(header: Text(sectionHeader)) { // Use the dynamic section header
                    ForEach(0..<10) { index in
                        let symbolName = selectedTab != .team ? "person.crop.circle.fill" : "square.fill"
                        let title = selectedTab != .team ? "Player Name" : "Team Name"
                        let subtitle = selectedTab != .team ? "Team Name" : "Total Points"
                        let detail = selectedTab != .team ? "Rank Points" : "Ranking Position"
                        
                        RankingEntryView(index: index,
                                         symbolName: symbolName,
                                         title: title,
                                         subtitle: subtitle,
                                         detail: detail)
                    }
                }
            }
        }
    }
}



struct RankingEntryView: View {
    var index: Int
    var symbolName: String
    var title: String
    var subtitle: String
    var detail: String
    
    var body: some View {
        HStack {
            Text("\(index + 1)")
                .font(.headline)
            Image(systemName: symbolName)
                .resizable()
                .frame(width: 30, height: 30)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
            }
            Spacer()
            Text(detail)
                .font(.subheadline)
        }
    }
}


struct ICCRankingView_Previews: PreviewProvider {
    static var previews: some View {
        ICCRankingView(selectedTab: .batsman)
    }
}
