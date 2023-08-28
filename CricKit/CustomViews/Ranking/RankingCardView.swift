//
//  RankingCardView.swift
//  swiftuisample
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI

struct MatchFormatCardView: View {
    var name: String
    
    var body: some View {
        VStack {
            Text(name)
                .font(.title)
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.2)
        .background(LinearGradient(gradient: Gradient(colors: [Color.appPrimary, Color.appBlacks, Color.appPrimary]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(10)
        .shadow(radius: 10)
        .rotation3DEffect(.degrees(10), axis: (x: 1, y: 0, z: 0))
        .offset(y: -20)
    }
}

struct RankingCardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(["Test", "ODI", "T20", "IPL"], id: \.self) { name in
                        NavigationLink(destination: RankingDetailsView(selectedTab: .batsman)) {
                            MatchFormatCardView(name: name)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct RankingCardView_Previews: PreviewProvider {
    static var previews: some View {
        RankingCardView()
    }
}
