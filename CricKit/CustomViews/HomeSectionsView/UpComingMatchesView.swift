//
//  UpComingMatchesView.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 17/08/23.
//

import SwiftUI

struct UpComingMatchesView: View {
    
    var upComingMatchModel : UpComingMatchModel
    
    var body: some View {
        VStack {
            HStack {
                Text(upComingMatchModel.matchName)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
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
                                .fontWeight(.bold)
                                .foregroundColor(Color.appWhites)
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
    
    var body: some View{
        HStack {
            Image(team.flag)
                .resizable()
                .frame(width: 35, height: 35)
            Text(team.name)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(Color.white)
        }
    }
}

struct DateAndVenueView: View {
    
    var matchDetail : String
    
    var body: some View {
        HStack {
            Text(matchDetail)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
            //.background(Color.white.opacity())
                .cornerRadius(5)
            Spacer()
        }
    }
}
