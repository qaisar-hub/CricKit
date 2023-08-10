//
//  PlayerBackgroundView.swift
//  CricKit
//
//  Created by Qaisar Raza on 10/08/23.
//

import SwiftUI

struct PlayerBackgroundView: View {
    
    var body: some View {
        Image("Dhoni")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

//        Text("MS DHONI")
//            .fixedSize()
//            .fontWidth(.expanded)
//            .font(.largeTitle)
//            .padding(.horizontal, 20)
//            .foregroundStyle(Color.appSecondary)
//            .rotationEffect(.degrees(-90))
//            .offset(x: -screenWidth * 0.40, y: -10)
    }
}

struct PlayerBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerBackgroundView()
    }
}
