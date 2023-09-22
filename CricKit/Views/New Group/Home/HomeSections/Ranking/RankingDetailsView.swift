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
    @ObservedObject var rankingViewModel = RankingViewModel()
    @EnvironmentObject private var appSettings: AppSettings
    var matchFormat: String
    
    init(matchFormat: String) {
        self.matchFormat = matchFormat
    }
    
    private var selectedTab: TabSelection {
        TabSelection.allCases[selectedTabIndex]
    }
    
    private var filteredData: [Ranking] {
            guard let category = rankingViewModel.category else {
                return []
            }

            switch selectedTab {
            case .batsman:
                return category.batsman
            case .bowler:
                return category.bowling
            case .allRounder:
                return category.allRounder
            case .team:
                return category.teams
            }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                appSettings.isDarkMode ? LinearGradient(Color.darkStart, Color.appBlacks).ignoresSafeArea() : LinearGradient(Color.appWhites).ignoresSafeArea()
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
                    if !filteredData.isEmpty {
                        ICCRankingView(selectedTab: selectedTab, rankingArray: filteredData)
                    } else {
                        Spacer()
                        LoadingIndicator()
                    }
                    
                    Spacer()
                }
                .onAppear {
                    self.rankingViewModel.fetchRankings(self.matchFormat)
                }
                .navigationTitle("ICC Rankings")
                .toolbarColorScheme(appSettings.isDarkMode ? .dark : .light, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CustomBackButton()
                    }
                })
            }
        }
        .scrollContentBackground(.hidden)
    }
}




struct RankingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RankingDetailsView(matchFormat: "Test")
    }
}
