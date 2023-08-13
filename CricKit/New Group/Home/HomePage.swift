//
//  HomePage.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI

struct HomePage: View {
    @State var selectedIndex = 0
    
    var body: some View {
        
        ZStack {
            Color.appBlacks.ignoresSafeArea()
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
                    }.padding()
                }
                Spacer()
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

struct RecentMatches: View {
    
    @StateObject var sectionProgress = HomeSection()
    
    var body: some View {
        HStack(spacing: 10) {
            
            if (sectionProgress.index == 0) {
				CardView(width: UIScreen.main.bounds.width / 2.5, height: 200)
                    .clipShape(MyCard())
                CardView(width: UIScreen.main.bounds.width / 2.5, height: 200)
                    .clipShape(MyCard())
                    .offset(y: -18)
            } else if (sectionProgress.index == 1) {
                Text("<<< Hello 1>>>")
            } else if (sectionProgress.index == 2) {
                Text("<<< Hello 2>>>")
            } else if (sectionProgress.index == 3) {
                Text("<<< Hello 3>>>")
            } else if (sectionProgress.index == 4) {
                Text("<<< Hello 4>>>")
            }
            
        }
        .padding()
    }
}
struct HomeBoard: View {
    
    @StateObject var sectionProgress = HomeSection()
	
	var width = UIScreen.main.bounds.width - 80
    
    var body: some View {
        VStack{
            CardView(featuredSection: true, width:  width , height: 200)
                .clipShape(MyCard())
                .padding()
                .shadow(color: Color.black, radius: 5)
            HomeSections(sectionProgress: sectionProgress)
                    .frame(width: width)
                    .padding(.top, 10)
                    .padding(.bottom, -10)
            ScrollView(showsIndicators: false) {
                VStack(spacing: -20) {
                    ForEach(0..<3) { items in
                        RecentMatches(sectionProgress: sectionProgress)
                            .frame(width: UIScreen.main.bounds.width - 80)
                    }
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
        }
    }
}

struct HomeSections: View {
    
    @ObservedObject var sectionProgress : HomeSection
	
	var width = UIScreen.main.bounds.width / 7
    var categoryData: [String] = ["All", "Live", "Upcoming", "Finished", "Ranking"]
    
    var body: some View{
        //ScrollView(.horizontal, showsIndicators: false) {
        VStack {
            HStack (spacing: 10) {
                ForEach(Array(categoryData.enumerated()), id: \.offset) { index, category in
                    CardView(width: width, height: 50, text: category)
                        .offset(y: CGFloat(-index*5))
                        .onTapGesture {
                            sectionProgress.index = index
                        }
                }
            }
            //  }
        }
    }
}
