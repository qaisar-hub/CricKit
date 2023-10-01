//
//  FavouriteTeamView.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 31/08/23.
//

import SwiftUI
import TipKit

struct FavouriteTeamView: View {
    
    @EnvironmentObject private var appSettings: AppSettings
    @State private var showModal = false
    let onFavouriteTeamChange: () -> Void
   
    private let favoriteTeamTip = FavoriteTeamTip(imageName: "star", header: "Add your favorite team", desc: "Your favourite team will be used in some places of the app. ")

    var body: some View {
        VStack{
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
                        favoriteTeamTip.invalidate(reason: .actionPerformed)
                    }
                    .popoverTip(favoriteTeamTip)
                    .task {
                        try? Tips.configure([
                            .datastoreLocation(.applicationDefault),
                            .displayFrequency(.immediate)
                        ])
                    }
            }
        }
       
        .sheet(isPresented: $showModal) {
            ZStack {
                appSettings.isDarkMode ? LinearGradient(Color.darkStart, Color.appBlacks) : LinearGradient(Color.appWhites)
                TeamList(showModal: $showModal, onFavouriteTeamChange: onFavouriteTeamChange)
                    .presentationDetents([.medium, .large])
            }.ignoresSafeArea()
            //.presentationContentInteraction(.scrolls)
        }
    }
}


struct TeamList: View {
    
    @Binding var showModal: Bool
    @EnvironmentObject private var appSettings: AppSettings
    let onFavouriteTeamChange: () -> Void
    
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
                    onFavouriteTeamChange()
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

struct FavouriteTeam: Hashable, Identifiable, Codable {
    var id = UUID()
    var team : String
    var teamFlag : String
}
