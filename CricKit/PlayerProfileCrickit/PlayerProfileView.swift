//
//  ContentView.swift
//  PlayerProfileCrickit
//
//  Created by qaisar.raza on 26/07/23.
//

import SwiftUI

struct PlayerProfileView: View {
    
    var body: some View {
        ZStack {
            PlayerBackgroundView()
            VStack {
                PlayerHeaderView()
                Spacer()
                PlayerStatsView()
            }
        }
        .ignoresSafeArea()
    }
    
    
}

struct PlayerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProfileView()
    }
}
