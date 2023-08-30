//
//  RankingCardView.swift
//  swiftuisample
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI

struct MatchFormatCardView: View {
    var name: String
	var width = UIScreen.main.bounds.width - 32
    
    var body: some View {
        VStack {
			HStack{
				Text(name)
					.font(.headline)
					.foregroundColor(.white)
					.padding()
				
				Text("Current Rankings")
					.font(.caption2)
					.font(.system(size: 14))
					.foregroundColor(.white)
					.padding()
				
				Image("teamInd")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 25, height: 25)
				
				Text("is at #1")
					.font(.caption2)
					.font(.system(size: 8))
					.foregroundColor(.white)
					.padding()
			}
            
        }
		.frame(width: width, height: 40)
		.background(Blur(style: .systemChromeMaterialDark))
		.clipShape(Capsule())
		.cornerRadius(10, corners: .allCorners)
    }
}

struct RankingCardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(["TEST", "ODI", "T20I"], id: \.self) { name in
                        NavigationLink(destination: RankingDetailsView(selectedTab: .batsman)) {
                            MatchFormatCardView(name: name)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
}

struct RankingCardView_Previews: PreviewProvider {
    static var previews: some View {
        RankingCardView()
    }
}
