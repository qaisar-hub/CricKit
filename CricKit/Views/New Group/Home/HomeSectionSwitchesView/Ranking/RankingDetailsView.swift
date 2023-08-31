//
//  RankingDetailsView.swift
//  swiftuisample
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI

enum TabSelection {
    case batsman, bowler, allRounder, team
}


struct RankingDetailsView: View {
    @State var selectedTab: TabSelection
    
    var body: some View {
        NavigationStack{
            VStack {
                TabView(selection: $selectedTab) {
                    ICCRankingView(selectedTab: selectedTab)
                        .tabItem {
                            Label("Batsman", systemImage: "person.fill")
                        }
                        .tag(TabSelection.batsman)
                    
                    ICCRankingView(selectedTab: selectedTab)
                        .tabItem {
                            Label("Bowler", systemImage: "bolt.fill")
                        }
                        .tag(TabSelection.bowler)
                    
                    ICCRankingView(selectedTab: selectedTab)
                        .tabItem {
                            Label("All Rounder", systemImage: "star.fill")
                        }
                        .tag(TabSelection.allRounder)
                    
                    ICCRankingView(selectedTab: selectedTab)
                        .tabItem {
                            Label("Team", systemImage: "person.3.fill")
                        }
                        .tag(TabSelection.team) // Add a new case to the TabSelection enum for Team
                }
                .navigationBarTitle("ICC Rankings")
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CustomBackButton()
                    }
                })
                
            }
        }
    }
}


struct RankingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RankingDetailsView(selectedTab: .allRounder)
    }
}
