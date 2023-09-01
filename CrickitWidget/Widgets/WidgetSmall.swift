//
//  WidgetSmall.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/08/23.
//

import SwiftUI
import WidgetKit

struct WidgetSmall: View {
    
    private var liveScorecardModel: LiveScoreCardModel
    
    init (_liveScorecardModel: LiveScoreCardModel) {
        self.liveScorecardModel = _liveScorecardModel
    }
    var body: some View {
        TeamViewSmall(liveScorecardModel: liveScorecardModel)
    }
}

struct TeamViewSmall: View {
    
    var liveScorecardModel: LiveScoreCardModel
    
    var body: some View {
        VStack {
            ForEach(liveScorecardModel.TeamStatus) { item in
                HStack {
                    Image(item.flag)
                        .resizable()
                    .frame(width: 15, height: 15)
                    Text(item.name)
                        .fontWeight(.medium)
                }
                HStack{
                    Text(item.yetToBat() ? item.yetToBatText() : "\(item.runs)/\(item.wickets) in \(item.overs) ovs")
                }
            }
        }.padding()
    }
}
