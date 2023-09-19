//
//  Crickit_TipKit.swift
//  CricKit
//
//  Created by ephrim.daniel on 19/09/23.
//

import SwiftUI
import TipKit

struct BookmarkTip: Tip {
	// Set Image Icon
	var asset: Image {
		Image(systemName: "lasso.and.sparkles")
	}
	// Set Title
	var title: Text {
		Text("Adding Live acitvities")
			.foregroundStyle(ColorManager.appPrimaryColor())
	}
	// Set Message to explain details
	var message: Text? {
		Text("Sit back and Relax - please tap below cards to enable live activities")
			.foregroundStyle(.gray)
	}
}
