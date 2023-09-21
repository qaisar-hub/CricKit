//
//  MatchDetails.swift
//  CricKit For Watch Watch App
//
//  Created by gokul.krishnan on 19/09/23.
//

import SwiftUI

struct MatchDetails: View {
    var doc: Document
    var body: some View {
        VStack {
            Spacer()
            Text("Match Stat")
                .fontWidth(.expanded)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(
                    colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
            
            HStack{
                Text(doc.fields.player1.stringValue)
                    .font(.system(size: 10))
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                Spacer()
                Text(doc.fields.player1Score.stringValue)
                    .font(.system(size: 10))
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
            HStack{
                Text(doc.fields.player2.stringValue)
                    .font(.system(size: 10))
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                Spacer()
                Text(doc.fields.player2Score.stringValue)
                    .font(.system(size: 10))
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
            HStack{
                Text("P'ship")
                    .font(.system(size: 10))
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                Spacer()
                Text(doc.fields.pship.stringValue)
                    .font(.system(size: 10))
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
            HStack{
                Text(doc.fields.bowler.stringValue)
                    .font(.system(size: 10))
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                Spacer()
                Text(doc.fields.bowlerStats.stringValue)
                    .font(.system(size: 10))
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
            HStack{
                Text("Wickets")
                    .font(.system(size: 10))
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                Spacer()
                Text(doc.fields.wickets.stringValue)
                    .font(.system(size: 10))
                    .foregroundColor(.red)
                    .fontWeight(.bold)
            }
            Text("Recent Balls")
                .font(.system(size: 10))
            Text(doc.fields.recentBalls.stringValue)
                .font(.system(size: 10))
            Spacer()
        }
    }
}


