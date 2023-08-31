//
//  RecentMatchShimmerView.swift
//  CricKit
//
//  Created by Qaisar Raza on 31/08/23.
//

import SwiftUI
import Shimmer

struct RecentMatchShimmerView: View {
    let width: CGFloat
	@EnvironmentObject private var appSettings: AppSettings
    
    let recentMatches = [RecentMatchModel(matchStatus: "India won by 10 wickets", TeamStatus: [TeamStats(name: "India", flag: "teamInd", overs: "50", runs: "100", wickets: "5"), TeamStats(name: "India", flag: "teamInd", overs: "50", runs: "100", wickets: "5")])]
    var body: some View {
        ForEach(Array(repeating: recentMatches[0], count: 5)) { recentMatch in
            RecentMatchView(recentMatchModel: recentMatch)
                .frame(width: width, height: 120)
                .clipShape(LiveMatchCard())
				.background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                .clipShape(LiveMatchCard())
                .cornerRadius(10, corners: .allCorners)
                .redacted(reason: .placeholder)
                .shimmering()
        }
    }
}

struct RecentMatchShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        RecentMatchShimmerView(width: UIScreen.main.bounds.width - 32)
    }
}
