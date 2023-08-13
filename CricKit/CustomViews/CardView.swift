//
//  cardView.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 08/08/23.
//

import SwiftUI

struct CardView: View {
    
    var featuredSection: Bool = false
    var width: CGFloat =  30
    var height: CGFloat = 30
    var text: String = "Coming Soon"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color.appSecondary)
            
            VStack {
                if( featuredSection ) {
                    MatchSummarySectionView()
                } else {
                    Text(text)
                        .font(.body)
                        .foregroundColor(.black)
                }
                
            }
            .multilineTextAlignment(.center)
        }
        .frame(width: width, height: height)
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
