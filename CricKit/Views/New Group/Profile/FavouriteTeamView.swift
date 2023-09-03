//
//  FavouriteTeamView.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 31/08/23.
//

import SwiftUI

struct FavouriteTeamView: View {
    
    @EnvironmentObject private var appSettings: AppSettings
    @State private var showModal = false
   
    
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .imageScale(.small)
                .font(.title)
                .foregroundColor(.gray)
            Text("Favourite Team")
                .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            Spacer()
            Text(appSettings.favouriteTeam.team)
                .font(.caption2)
                .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            Image(appSettings.favouriteTeam.teamFlag)
                .resizable()
                .frame(width: 25, height: 25)
                .onTapGesture {
                    showModal = true
                }
        }
        .sheet(isPresented: $showModal) {
            TeamList(showModal: $showModal)
            .presentationDetents([.medium, .large])
            //.presentationContentInteraction(.scrolls)
        }
    }
}


struct TeamList: View {
    
    @Binding var showModal: Bool
    @EnvironmentObject private var appSettings: AppSettings
    
    var model = FavouriteTeamList(teamList: [FavouriteTeam(team: "India", teamFlag: "teamInd"),
                                             FavouriteTeam(team: "Australia", teamFlag: "teamAus"),
                                             FavouriteTeam(team: "England", teamFlag: "teamEng"),
                                             FavouriteTeam(team: "South Africa", teamFlag: "teamRSA"),
                                             FavouriteTeam(team: "New Zealand", teamFlag: "teamNZ"),
                                             FavouriteTeam(team: "Pakistan", teamFlag: "teamPak"),
                                             FavouriteTeam(team: "Srilanka", teamFlag: "teamSri"),
                                             FavouriteTeam(team: "Bangladesh", teamFlag: "teamBan"),
                                             FavouriteTeam(team: "West Indies", teamFlag: "teamWI"),
                                             FavouriteTeam(team: "Zimbabwe", teamFlag: "teamZim")])
    
    var body: some View {
        VStack {
            Text("Pick your favourite team")
                .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                .padding()
            List(model.teamList, id: \.self) { team in
                Button {
                    appSettings.favouriteTeam = team
                    showModal = false
                } label: {
                    HStack {
                        Spacer()
                        Text("\(team.team)")
                            .foregroundColor(ColorManager.appPrimaryColor())
                        Image("\(team.teamFlag)")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct FavouriteTeamList: Hashable, Identifiable {
    var id = UUID()
    var teamList : [FavouriteTeam]
}

struct FavouriteTeam: Hashable, Identifiable {
    var id = UUID()
    var team : String
    var teamFlag : String
}