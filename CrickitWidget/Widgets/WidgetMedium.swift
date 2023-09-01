//
//  WidgetMedium.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import SwiftUI
import WidgetKit

struct WidgetMedium: View {
    
    private var liveScorecardModel: LiveScoreCardModel
    
    init (_liveScorecardModel: LiveScoreCardModel) {
        self.liveScorecardModel = _liveScorecardModel
    }
    var body: some View {
        VStack(spacing: 10){
            Text(liveScorecardModel.matchHeader)
            Text(liveScorecardModel.matchStatus)
            TeamView(liveScorecardModel: liveScorecardModel)
                .padding(.leading, 10)
                .padding(.trailing, 10)
        }
    }
}

struct TeamView: View {
    
    var liveScorecardModel: LiveScoreCardModel
    
    var body: some View {
        ForEach(liveScorecardModel.TeamStatus, id:\.self) { item in
            HStack {
                Image(item.flag)
                    .resizable()
                    .frame(width: 15, height: 15)
                Text(item.name)
                Text(item.yetToBat() ? item.yetToBatText() : "\(item.runs)/\(item.wickets) in \(item.overs) ovs")
            }
        }
    }
}
