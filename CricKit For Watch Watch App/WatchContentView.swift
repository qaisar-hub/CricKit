//
//  ContentView.swift
//  CricKit For Watch Watch App
//
//  Created by gokul.krishnan on 18/09/23.
//
import SwiftUI

struct WatchContentView: View {
    @ObservedObject var watchViewModel = WatchViewModel()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    Text("Live Matches")
                        .fontWidth(.expanded)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(
                            colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                    Spacer()
                }
                .padding(.top)
                
                if watchViewModel.isLoading {
                    ProgressView()
                } else {
                    
                    List(watchViewModel.liveMatches.documents,id: \.name)  { match in
                        let title = match.fields.matchHeader.stringValue
                        NavigationLink(destination: MatchDetails(doc: match)) {
                            VStack(spacing: 5) {
                                HStack{
                                    Text(title)
                                        .font(.system(size: 10))
                                        .foregroundColor(.blue)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                HStack {
                                    Text(match.fields.teamName.stringValue)
                                        .font(.system(size: 10))
                                        .foregroundColor(.white)
                                    
                                    Text(match.fields.runs.stringValue + "(" + match.fields.wickets.stringValue + ")")
                                        .foregroundColor(.green)
                                        .font(.system(size: 10))
                                        .animation(.easeIn)
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text(match.fields.overs.stringValue + " overs")
                                        .font(.system(size: 10))
                                }
                                
                            }
                        }
                    }
                    .padding(.top)
                }
                
            }
        }
    }
}

#Preview {
    WatchContentView()
}
