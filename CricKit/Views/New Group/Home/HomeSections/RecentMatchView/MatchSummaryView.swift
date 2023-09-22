//
//  MatchSummaryView.swift
//  CricKit
//
//  Created by gokul.krishnan on 22/09/23.
//

import SwiftUI

struct BatsmanPlayer {
    var name: String
    var runs: String
}
struct BowlerPlayer {
    var name: String
    var wickets: String
}
struct RecentMatchSummary: View {
    @EnvironmentObject private var appSettings: AppSettings
    var teamStat: [TeamStats]
    var result :String
    var body: some View {
        NavigationStack {
            ZStack {
                appSettings.isDarkMode ? LinearGradient(Color.darkStart, Color.appBlacks).ignoresSafeArea() : LinearGradient(Color.appWhites).ignoresSafeArea()
                Form {
                    ForEach(teamStat) { stat in
                        Section(header: Text(stat.name + " " + stat.runs + "(" + stat.wickets + ")").font(.subheadline).foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))) {
                            
                            ForEach(0..<stat.batsMen.count, id: \.self) { index in
                                BatsmenSection(batsmen: [
                                    BatsmanPlayer(name: stat.batsMen[index] as! String, runs: stat.batsMenScore[index] as! String),
                                ])
                            }
                        }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                        Section {
                            ForEach(0..<stat.batsMen.count, id: \.self) { index in
                                BowlersSection(bowlers: [
                                    BowlerPlayer(name: stat.bowlers[index] as! String, wickets: stat.bStat[index] as! String)
                                ])
                            }
                        }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                    }
                    Section {
                        Text(result)
                            .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                            .font(.headline)
                            .padding()
                    }.listRowBackground(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
                }
                .navigationTitle("Match Summary")
                .toolbarColorScheme(appSettings.isDarkMode ? .dark : .light, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                
            }
            
        }
        .scrollContentBackground(.hidden)
    }
}
struct BatsmenSection: View {
    var batsmen: [BatsmanPlayer]
    @EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        ForEach(batsmen, id: \.name) { batsman in
            HStack {
                Text(batsman.name)
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                Spacer()
                Text("\(batsman.runs)")
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            }
        }
        
    }
}
struct BowlersSection: View {
    var bowlers: [BowlerPlayer]
    @EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        
        ForEach(bowlers, id: \.name) { bowler in
            HStack {
                Text(bowler.name)
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                Spacer()
                Text("\(bowler.wickets)")
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            }
        }
    }
}

