//
//  WidgetMedium.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import SwiftUI
import WidgetKit

struct WidgetMedium: View {
    
    private var liveScorecard: LiveScoreCard
    
    init (_liveScorecard: LiveScoreCard) {
        self.liveScorecard = _liveScorecard
    }
    var body: some View {
        Text("Hello, World medium widget!")
    }
}

struct WidgetMedium_Previews: PreviewProvider {
    static var previews: some View {
        WidgetMedium(_liveScorecard: LiveScoreCard(matchName: "India vs Australia", matchStatus: "India won by 100 Runs", playerOfTheMatch: "Virat Kohli", liveScore: [LiveScore(name: "IND", flagImageName: "teamInd", runs: 280, wickets: 6, overs: 50), LiveScore(name: "AUS", flagImageName: "teamAus", runs: 180, wickets: 5, overs: 40)]))
        
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
