//
//  UpComingMatchesView.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 17/08/23.
//

import SwiftUI

struct UpComingMatchesView: View {
    
    var upComingMatchModel : UpComingMatchModel
	@EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        VStack {
            HStack {
                Text(upComingMatchModel.matchName)
                    .font(.subheadline)
					.foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                Spacer()
            }
            
            HStack {
                ForEach(0..<upComingMatchModel.TeamStatus.count) { index in
                    HStack {
                        if (index == 0) {
                            Spacer()
                            TeamView(team: upComingMatchModel.TeamStatus[index])
                            Text("vs")
                                .font(.subheadline)
                                .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                        } else {
                            TeamView(team: upComingMatchModel.TeamStatus[index])
                        }
                    }
                }
            }
            DateAndVenueView(matchDetail: upComingMatchModel.matchDetails)
        }
        .padding()
    }
}


//struct UpComingMatchesView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpComingMatchesView()
//    }
//}


struct TeamView: View {
    
    let team: UpComingMatchStats
	@EnvironmentObject private var appSettings: AppSettings
    
    var body: some View{
        HStack {
            Image(team.flag)
                .resizable()
                .frame(width: 35, height: 35)
            Text(team.name)
                .font(.subheadline)
                .foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
        }
    }
}

struct DateAndVenueView: View {
    
    var matchDetail : String
	@EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        HStack {
            Text(matchDetail)
                .font(.subheadline)
                .foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                .cornerRadius(5)
            Spacer()
        }
    }
}
