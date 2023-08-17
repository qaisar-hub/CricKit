//
//  PlayerStatsView.swift
//  CricKit
//
//  Created by Qaisar Raza on 10/08/23.
//

import SwiftUI

struct PlayerStatsView: View {
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    var playerDetails: [(topLeftText: String, bottomRightText: String)] = [
        (topLeftText: "AGE", bottomRightText: "45"),
        (topLeftText: "Matches", bottomRightText: "538"),
        (topLeftText: "ICC Rank", bottomRightText: "--")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack{
                Text("WICKET KEEPER")
                    .padding()
                    .fontWidth(.expanded)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(Color.appWhites)
                Spacer()
            }
            HStack(spacing: 16) {
                ForEach(playerDetails, id: \.topLeftText) { data in
                    RoundedRectangleView(topLeftText: data.topLeftText, bottomRightText: data.bottomRightText)
                }
            }
            
            Button {
                // Code To Show Full Details
            } label: {
                Text("FULL BIO")
                    .foregroundColor(Color.appSecondary)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .frame(width: screenWidth * 0.8, height: 55)
                    .padding(.horizontal)
                    .background(Color.black)
            }
            .cornerRadius(30)
        }
        .padding()
        .background(Blur(style: .systemChromeMaterialDark))
        .cornerRadius(20)
    }
}

struct PlayerStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerStatsView()
    }
}
