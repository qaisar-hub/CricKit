//
//  WidgetSmall.swift
//  WidgetCrickitExtension
//
//  Created by  Ephrim Daniel J on 04/09/23.
//

import SwiftUI

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
                    if (item.yetToBat()) {
                        Text(item.yetToBatText())
                    } else {
                        Text("\(item.runs)/\(item.wickets) in \(item.overs) ovs")
                    }
                }
            }
        }
    }
}

