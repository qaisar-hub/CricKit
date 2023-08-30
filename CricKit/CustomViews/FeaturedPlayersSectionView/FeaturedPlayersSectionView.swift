//
//  FeaturedPlayersSectionView.swift
//  CricKit
//
//  Created by ephrim.daniel on 14/08/23.
//

import SwiftUI

struct FeaturedPlayersSectionView: View {
        
    var featuredPlayer : FeaturedPlayersModel
	var playerImage : String
    
    var body: some View {
        HStack {
            VStack {
				Image(playerImage)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 40, height: 40)
					.clipShape(Circle())
            }
            .padding(.all, 8)
            Text(featuredPlayer.name)
                .foregroundColor(Color.white)
			Spacer()
			Text(featuredPlayer.country)
				.foregroundColor(Color.white)
				.offset(y: -10)
			Image(featuredPlayer.flag)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 30, height: 30)
				.offset(y: -10)
			Image("batsman")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 30, height: 30)
				.clipShape(Circle())
				.offset(y: -10)
        }
    }
}

struct PlayerDetailView: View {
    var playerTeamName: String
    var playerImage: String
    
    var body: some View {
        PlayerProfileView(playerImage: playerImage, playerTeamName: playerTeamName)
    }
}


