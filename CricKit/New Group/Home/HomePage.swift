//
//  HomePage.swift
//  CricKit
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI

struct HomePage: View {
    @State var selectedIndex = 0
    
    var body: some View {
        ZStack {
            Color.appBlacks
                .clipShape(BackgroundCard())
            VStack(spacing: 0) {
                
                switch selectedIndex {
                case 0:
                    HomeBoard()
                case 1:
                    ShopPage()
                default:
                    UserProfilePage()
                }
                
                VStack() {
                    HStack (alignment: .center, spacing: 30) {
                        customTabBar(selectedIndex: $selectedIndex)
                    }
                }
                Spacer()
            }
        }.background(Color.linearColor)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
struct HomeBoard: View {
    
    @StateObject var sectionProgress = HomeSection()
    
    var width = UIScreen.main.bounds.width - 80
    
    var body: some View {
        VStack{
            CardView(featuredSection: true, width:  width , height: 200)
                .clipShape(LiveMatchCard())
                .background(Blur(style: .systemChromeMaterialDark))
                .clipShape(LiveMatchCard())
                .cornerRadius(10, corners: .allCorners)
                .shadow(color: Color.black, radius: 10)
            HomeSections(sectionProgress: sectionProgress)
                    .frame(width: width)
                    .padding(.top, 10)
                    .padding(.bottom, -10)
            ScrollView(showsIndicators: false) {
                VStack(spacing: -20) {
                        HomeSectionSwitches(sectionProgress: sectionProgress)
                            .frame(width: UIScreen.main.bounds.width - 30)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
            .shadow(radius: 5)
        }
    }
}

struct HomeSectionSwitches: View {
    let categoryDataImages: [String] = ["playerVirat", "playerJoeRoot", "playerBabar", "playerSteveSmith", "playerKaneWill"]
    
    
    @StateObject var sectionProgress = HomeSection()
    
    var body: some View {
        VStack(spacing: 10) {
            if (sectionProgress.index == 0) {
                ForEach(Array(categoryDataImages.enumerated()), id: \.offset) { index, category in
                    HStack {
                        RecentMatchSectionView()
                            .shadow(color: Color.black, radius: 5)
                    }
                }
                
            } else if (sectionProgress.index == 1) {
                Text("<<< Hello 1>>>")
            } else if (sectionProgress.index == 2) {
                VStack {
                    FeaturedPlayersSectionView()
                }
            } else if (sectionProgress.index == 3) {
                Text("<<< Hello 3>>>")
            } else if (sectionProgress.index == 4) {
                Text("<<< Hello 4>>>")
            }
            
        }
        .padding()
    }
}
