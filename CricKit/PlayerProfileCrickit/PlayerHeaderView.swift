//
//  PlayerHeaderView.swift
//  CricKit
//
//  Created by Qaisar Raza on 10/08/23.
//

import SwiftUI

struct PlayerHeaderView: View {
    
    var linearColor = LinearGradient(colors: [Color.appSecondary, Color.appPrimary, Color.appSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        VStack {
            Color.clear
                .frame(height: 40)
            
            Text("INDIA")
                .padding()
                .fontWidth(.expanded)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundStyle(linearColor)
        }
    }
}

struct PlayerHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerHeaderView()
    }
}
