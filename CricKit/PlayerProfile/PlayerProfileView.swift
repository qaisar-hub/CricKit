//
//  ContentView.swift
//  PlayerProfileCrickit
//
//  Created by qaisar.raza on 26/07/23.
//

import SwiftUI

struct PlayerProfileView: View {
    
    let playerImage: String
    let playerTeamName: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBlacks
                    .clipShape(BackgroundCard())
                PlayerBackgroundView(imageName: playerImage)
                                .offset(x: 120.0)
               
                VStack {
                    Spacer()
                    HStack {
                        Text("MS DHONI ")
                            .font(.system(size: 70))
                            .foregroundStyle(
                              Color.appWhites)
                            .fontWeight(.heavy)
                            .rotationEffect(.degrees(-90))
                       Spacer()
                    }.offset(x: UIScreen.main.bounds.minX - 100)
                    Spacer()
                    HStack {
                        PlayerStatsView()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton()
                }
            })
            .ignoresSafeArea()
        }
    }
}

struct PlayerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProfileView(playerImage: "pp_dhoni", playerTeamName: "INDIA")
    }
}
