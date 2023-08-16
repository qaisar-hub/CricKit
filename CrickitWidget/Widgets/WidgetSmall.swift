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
        VStack {
            HStack {
                Image(liveScorecard.liveScore[0].flagImageName)
                    .resizable()
                .frame(width: 15, height: 15)
                Text(liveScorecard.liveScore[0].name)
                    .fontWeight(.medium)
            }
            
            HStack{
                Text("\(liveScorecard.liveScore[0].runs)/\(liveScorecard.liveScore[0].wickets) in")
                Text("\(liveScorecard.liveScore[0].overs)")
                    .font(.caption)
            }
            
            HStack {
                Image(liveScorecard.liveScore[1].flagImageName)
                    .resizable()
                .frame(width: 15, height: 15)
                Text(liveScorecard.liveScore[1].name)
                    .fontWeight(.medium)
            }
            HStack{
                Text("\(liveScorecard.liveScore[1].runs)/\(liveScorecard.liveScore[1].wickets) in")
                Text("\(liveScorecard.liveScore[1].overs)")
                    .font(.caption)
            }
            
        }.padding()
    }
}

struct WidgetSmall_Previews: PreviewProvider {
    static var previews: some View {
        WidgetSmall(_liveScorecard: LiveScoreCard(matchName: "India vs Australia", matchStatus: "India won by 100 Runs", playerOfTheMatch: "Virat Kohli", liveScore: [LiveScore(name: "IND", flagImageName: "teamInd", runs: 280, wickets: 6, overs: 50), LiveScore(name: "AUS", flagImageName: "teamAus", runs: 180, wickets: 5, overs: 40)]))
        
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
