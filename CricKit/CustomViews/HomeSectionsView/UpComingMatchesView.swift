//
//  UpComingMatchesView.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 17/08/23.
//

import SwiftUI

struct UpComingMatchesView: View {
    let leftTeam = Team(name: "IND", flagImageName: "teamInd", runs: 280, wickets: 6, overs: 50)
    let rightTeam = Team(name: "AUS", flagImageName: "teamAus", runs: 180, wickets: 5, overs: 40)
    
    var body: some View {
        VStack {
            HStack {
                Text("1st ODI Match, Bangalore")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Spacer()
            }
            
            HStack{
                Spacer()
                TeamView(flagImageName: leftTeam.flagImageName, teamName: leftTeam.name)
                Text("vs")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.appWhites)
                TeamView(flagImageName: rightTeam.flagImageName, teamName: rightTeam.name)
                
            }

            DateAndVenueView()
                .padding(.bottom, 5)
            
        }.padding()
//            .cornerRadius(25, corners: .allCorners)
//            .background(Blur(style: .systemChromeMaterialDark))
//            .clipShape(LiveMatchCard())
    }
}

struct UpComingMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        UpComingMatchesView()
    }
}


struct TeamView: View {
    
    let flagImageName: String
    let teamName: String
    
    var body: some View{
        HStack {
            Image(flagImageName)
                .resizable()
                .frame(width: 35, height: 35)
            Text(teamName)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.white)
        }
    }
}

struct DateAndVenueView: View {
    var body: some View {
        HStack {
            Text("Thu, 31st Aug . 01.00 PM")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                //.background(Color.white.opacity())
                .cornerRadius(5)
            Spacer()
        }
    }
}
