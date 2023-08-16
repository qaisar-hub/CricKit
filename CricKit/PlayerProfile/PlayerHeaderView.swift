//
//  PlayerHeaderView.swift
//  CricKit
//
//  Created by Qaisar Raza on 10/08/23.
//

import SwiftUI

struct PlayerHeaderView: View {
    let teamName: String
    
    var body: some View {
        VStack {
            Color.clear
                .frame(height: 40)
            
            Text(teamName)
                .padding()
                .fontWidth(.expanded)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundStyle(Color.linearColor)
        }
        .padding(.horizontal, 20)
    }
}

struct PlayerHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerHeaderView(teamName: "INDIA")
    }
}
