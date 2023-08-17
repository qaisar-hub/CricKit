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
        VStack{
            Text(liveScorecard.matchName)
            TeamView(liveScorecard: liveScorecard)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            Text(liveScorecard.matchStatus)
        }
    }
}

struct WidgetMedium_Previews: PreviewProvider {
    static var previews: some View {
        WidgetMedium(_liveScorecard: LiveScoreCard(matchName: "1st ODI, India vs Australia at Vizag", matchStatus: "India still need 100 runs", playerOfTheMatch: "Virat Kohli", liveScore: [LiveScore(name: "IND", flagImageName: "teamInd", runs: 180, wickets: 4, overs: 30), LiveScore(name: "AUS", flagImageName: "teamAus", runs: 280, wickets: 5, overs: 50)]))
        
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

struct TeamView: View {
    
    var liveScorecard: LiveScoreCard
    
    var body: some View {
        ForEach(liveScorecard.liveScore, id:\.self) { item in
            HStack {
                Image(item.flagImageName)
                    .resizable()
                    .frame(width: 15, height: 15)
                Text(item.name)
                    .fontWeight(.medium)
                
                Text("\(item.runs)/\(item.wickets) in")
                Text("\(item.overs) Overs")
            }
        }
    }
}
