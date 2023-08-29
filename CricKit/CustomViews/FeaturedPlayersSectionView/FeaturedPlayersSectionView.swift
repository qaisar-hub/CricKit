//
//  FeaturedPlayersSectionView.swift
//  CricKit
//
//  Created by ephrim.daniel on 14/08/23.
//

import SwiftUI

struct FeaturedPlayersSectionView: View {
    
    var categoryDataImages: [String] = ["playerVirat", "playerJoeRoot", "playerBabar", "playerSteveSmith", "playerKaneWill"]
    
    var categoryDataPlayerName: [String] = ["Virat Kohli [Player desc for 2/3 lines]", "Joe Root [Player desc for 2/3 lines]", "Babar Azam [Player desc for 2/3 lines]", "Steve Smith [Player desc for 2/3 lines]", "Kane Williamson [Player desc for 2/3 lines]"]
    
    var featuredPlayer : FeaturedPlayersModel
    
    var body: some View {
        HStack {
            VStack {
                //                        Image(imageName)
                //                            .resizable()
                //                            .aspectRatio(contentMode: .fill)
                //                            .frame(width: 40, height: 40)
                //                            .clipShape(Circle())
            }
            .padding(.all, 8)
            Text(featuredPlayer.name)
                .foregroundColor(Color.white)
            Spacer()
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


