//
//  WidgetSmall.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import SwiftUI
import WidgetKit

struct WidgetSmall: View {
    
    private var liveScorecard: LiveScoreCard
    
    init (_liveScorecard: LiveScoreCard) {
        self.liveScorecard = _liveScorecard
    }
    var body: some View {
        TeamViewSmall(liveScorecard: liveScorecard)
    }
}

struct WidgetSmall_Previews: PreviewProvider {
    static var previews: some View {
        WidgetSmall(_liveScorecard: LiveScoreCard(matchName: "India vs Australia", matchStatus: "India won by 100 Runs", playerOfTheMatch: "Virat Kohli", liveScore: [LiveScore(name: "IND", flagImageName: "teamInd", runs: 280, wickets: 6, overs: 50), LiveScore(name: "AUS", flagImageName: "teamAus", runs: 180, wickets: 5, overs: 40)]))
        
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

struct TeamViewSmall: View {
    
    var liveScorecard: LiveScoreCard
    
    var body: some View {
        VStack {
            ForEach(liveScorecard.liveScore) { item in
                HStack {
                    Image(item.flagImageName)
                        .resizable()
                    .frame(width: 15, height: 15)
                    Text(item.name)
                        .fontWeight(.medium)
                }
                HStack{
                    Text("\(item.runs)/\(item.wickets) in")
                    Text("\(item.overs)")
                        .font(.caption)
                }
            }
        }.padding()
    }
}
