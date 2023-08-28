//
//  FeaturedPlayersModel.swift
//  CricKit
//
//  Created by ephrim.daniel on 28/08/23.
//

import Foundation

struct FeaturedPlayersModel: Identifiable, Hashable {
	static func == (lhs: FeaturedPlayersModel, rhs: FeaturedPlayersModel) -> Bool {
		return lhs.id == rhs.id
	}
	var id = UUID()
	var name: String
}
