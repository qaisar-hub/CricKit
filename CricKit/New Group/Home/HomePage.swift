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
                    AboutPage()
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
                CardView(width: 140, height: 200)
                    .clipShape(MyCard())
                CardView(width: 140, height: 200)
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
    
    var body: some View {
        VStack{
            CardView(width: 300, height: 200)
                .clipShape(MyCard())
                .padding()
            HomeSections(sectionProgress: sectionProgress)
            .padding(.top, 10)
            .padding(.bottom, -10)
            ScrollView(showsIndicators: false) {
                VStack(spacing: -20) {
                    ForEach(0..<3) { items in
                        RecentMatches(sectionProgress: sectionProgress)
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
    
    var body: some View{
        VStack{
            HStack (spacing: 10) {
                ForEach(0..<5) { items in
                    if( items == 0) {
                        CardView(width: 50, height: 50)
                            .rotation3DEffect(.degrees(5), axis: (x: 0, y: 2, z: 0))
                            .onTapGesture {
                                sectionProgress.index = 0
                            }
                    }
                    else if( items == 1) {
                        CardView(width: 50, height: 50)
                            .rotation3DEffect(.degrees(5), axis: (x: 0, y: 2, z: 0))
                            .offset(y: -10)
                            .onTapGesture {
                                sectionProgress.index = 1
                            }
                    } else if( items == 2) {
                        CardView(width: 50, height: 50)
                            .rotation3DEffect(.degrees(5), axis: (x: 0, y: 2, z: 0))
                            .offset(y: -15)
                            .onTapGesture {
                                sectionProgress.index = 2
                            }
                        
                    } else if( items == 3) {
                        CardView(width: 50, height: 50)
                            .rotation3DEffect(.degrees(5), axis: (x: 0, y: 2, z: 0))
                            .offset(y: -20)
                            .onTapGesture {
                                sectionProgress.index = 3
                            }
                    }
                    
                    else if( items == 4) {
                        CardView(width: 50, height: 50)
                            .rotation3DEffect(.degrees(5), axis: (x: 0, y: 2, z: 0))
                            .offset(y: -25)
                            .onTapGesture {
                                sectionProgress.index = 4
                            }
                    }
                }
            }
        }
    }
}
