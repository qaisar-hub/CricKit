//
//  WidgetMedium.swift
//  CrickitWidgetExtension
//
//  Created by ephrim.daniel on 03/09/23.
//

import SwiftUI

struct WidgetMedium: View {
	
	private var liveScorecardModel: LiveScoreCardModel
	
	init (_liveScorecardModel: LiveScoreCardModel) {
		self.liveScorecardModel = _liveScorecardModel
	}
	var body: some View {
		VStack(spacing: 10){
			Text(liveScorecardModel.matchHeader)
				.font(.system(size: 13))
				.fontWeight(.medium)
				.foregroundColor(.gray)
			Text(liveScorecardModel.matchStatus)
				.foregroundColor(ColorManager.appPrimaryColor())
			TeamViewMedium(liveScorecardModel: liveScorecardModel)
				.padding(.leading, 10)
				.padding(.trailing, 10)
		}
	}
}

struct TeamViewMedium: View {
	
	var liveScorecardModel: LiveScoreCardModel
	
	var body: some View {
		ForEach(liveScorecardModel.TeamStatus, id:\.self) { item in
			HStack {
				Image(item.flag)
					.resizable()
					.frame(width: 15, height: 15)
				Text(item.name)
					.fontWeight(.medium)
				Text(item.yetToBat() ? item.yetToBatText() : "\(item.runs)/\(item.wickets) in \(item.overs) ovs")
			}
		}
	}
}
