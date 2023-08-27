//
//  LiveScoreCardShimmerView.swift
//  CricKit
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI
import Shimmer

struct LiveScoreCardShimmerView: View {
    let width: CGFloat
    
    let liveScoreCardDummylists = [LiveScoreCardModel(matchStatus: "India needs 50 runs to win", matchHeader: "ICC WC 2023, India vs Australia", isLive: true, TeamStatus: [TeamStats(name: "India", flag: "teamInd", overs: "50", runs: "100", wickets: "5"), TeamStats(name: "India", flag: "teamInd", overs: "50", runs: "100", wickets: "5")])]
    
    var body: some View {
        ForEach(Array(repeating: liveScoreCardDummylists[0], count: 5)) { liveScoreItem in
            LiveScoreCardView(liveScoreCardData: liveScoreItem)
                .frame(width: width , height: 200)
                .clipShape(LiveMatchCard())
                .background(Blur(style: .systemChromeMaterialDark))
                .clipShape(LiveMatchCard())
                .cornerRadius(10, corners: .allCorners)
                .redacted(reason: .placeholder)
                .shimmering()
        }
    }
}

struct LiveScoreCardShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        LiveScoreCardShimmerView(width: UIScreen.main.bounds.width - 80)
    }
}
