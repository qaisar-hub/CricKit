//
//  LiveModePage.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 16/09/23.
//

import SwiftUI

struct LiveModePage: View {

    var matchHeader = ""
    var matchStatus = ""

    @ObservedObject var liveModeViewModel = LiveModeViewModel()

    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(Color.darkStart, Color.appBlacks).ignoresSafeArea()
                HStack{
                    VStack(spacing: 25) {
                        
                        HStack {
                            Text(matchHeader)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white).opacity(0.8)
                            Spacer()
                        }.padding(.leading, 10)
                        
                        HStack {
                            Text(matchStatus)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(ColorManager.appPrimaryColor())
                            Spacer()
                        }.padding(.leading, 10)
                        
                        HStack {
                            Image(liveModeViewModel.liveModelForMatch?.teamFlag ?? "")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text(liveModeViewModel.liveModelForMatch?.teamName ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                        }.padding(.leading, 10)
                        
                        
                        HStack {
                            Text(liveModeViewModel.liveModelForMatch?.runs ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            if ((liveModeViewModel.liveModelForMatch?.runs) != nil) {
                                Text("/")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                            Text(liveModeViewModel.liveModelForMatch?.wickets ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            if ((liveModeViewModel.liveModelForMatch?.overs) != nil) {
                                Text("in \(liveModeViewModel.liveModelForMatch?.overs ?? "") ovs")
                                    .font(.title3)
                                    .foregroundStyle(.white).opacity(0.8)
                                    .fontWeight(.bold)
                                Text("at \(liveModeViewModel.liveModelForMatch?.crr ?? "") rpo")
                                    .font(.title3)
                                    .foregroundStyle(.white).opacity(0.8)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                        } .padding(.leading, 10)
                        
                        HStack {
                            Text(liveModeViewModel.liveModelForMatch?.player1 ?? "")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                            Text(liveModeViewModel.liveModelForMatch?.player1Score ?? "")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                        }.padding(.leading, 10)
                        
                        HStack {
                            Text(liveModeViewModel.liveModelForMatch?.player2 ?? "")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                            Text(liveModeViewModel.liveModelForMatch?.player2Score ?? "")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                        }.padding(.leading, 10)
                        
                        HStack {
                            Text(liveModeViewModel.liveModelForMatch?.bowler ?? "")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                            Text(liveModeViewModel.liveModelForMatch?.bowlerStats ?? "")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                        }.padding(.leading, 10)
                        
                        HStack {
                            if ((liveModeViewModel.liveModelForMatch?.recentBalls) != nil) {
                                Text("Recent Balls: ")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white).opacity(0.8)
                            }
                            Text(liveModeViewModel.liveModelForMatch?.recentBalls ?? "")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white).opacity(0.8)
                            Spacer()
                        }.padding(.leading, 10)
                        
                        HStack {
                            if ((liveModeViewModel.liveModelForMatch?.lastWicket) != nil) {
                                Text("Last Wicket: ")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white).opacity(0.6)
                            }
                            Text(liveModeViewModel.liveModelForMatch?.lastWicket ?? "")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white).opacity(0.8)
                            Spacer()
                        }.padding(.leading, 10)
                        
                        ShowLottieAnimation(ballState: liveModeViewModel.liveModelForMatch?.recentBalls.last)
                        Spacer()
                    }
                }.padding()
            }
            .onAppear() {
                print("<<< onAppear live mode")
                liveModeViewModel.getLiveScore(for: matchHeader)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton(liveMode: true)
                }
            })
        }
        
    }
}

#Preview {
    LiveModePage()
}
