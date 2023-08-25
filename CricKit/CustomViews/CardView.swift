//
//  cardView.swift
//  CricKit
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
            VStack {
                if( featuredSection ) {
                    //Commented because we are not using
                    //MatchLiveSectionView()
                } else {
                    Text(text)
                        .font(.body)
                        .foregroundColor(.black)
                }
                
            }
            .multilineTextAlignment(.center)
        }
        .frame(width: width, height: height)
        .shadow(color: Color.black, radius: 10)
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
