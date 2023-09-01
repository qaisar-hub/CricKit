//
//  RankingDetailsView.swift
//  swiftuisample
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI

enum TabSelection: String, CaseIterable, Identifiable {
    case batsman = "Batsman", bowler = "Bowler", allRounder = "All Rounder", team = "Team"
    
    var id: String { self.rawValue }
}

struct RankingDetailsView: View {
    @State private var selectedTabIndex = 0
    
    private var selectedTab: TabSelection {
        TabSelection.allCases[selectedTabIndex]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                        .frame(minHeight: 0, maxHeight: 16) 
                Picker("", selection: $selectedTabIndex) {
                    ForEach(0..<TabSelection.allCases.count, id: \.self) { index in
                        Text(TabSelection.allCases[index].rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                ICCRankingView(selectedTab: selectedTab)
                
                Spacer()
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




struct RankingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RankingDetailsView()
    }
}
