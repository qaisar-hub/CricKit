//
//  HomePage.swift
//  CricKit
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI

struct HomePage: View {
    @State var selectedIndex = 0
    
    @ObservedObject var liveScoreCardViewModel = LiveScoreCardViewModel()
    @EnvironmentObject private var appSettings: AppSettings
    @State private var showSignInSheet = false
    
	
    var body: some View {
        NavigationStack {
            ZStack {
                
                if appSettings.isDarkMode {
                    Color.appBlacks
                        .clipShape(BackgroundCard())
                } else {
                    Color.appWhites
                        .clipShape(BackgroundCard())
                }
                
                VStack(spacing: 0) {
                    AppLogoView()
                    switch selectedIndex {
                    case 0:
                        HomeBoard(liveScoreCardViewModel: liveScoreCardViewModel)
                    case 1:
						LiveMatches()
                    default:
                        UserProfilePage()
                    }
                    
                    VStack() {
                        HStack (alignment: .center, spacing: 30) {
                            customTabBar(showSignInSheet: $showSignInSheet, selectedIndex: $selectedIndex)
                        }
                        .padding(.top, 16)
                        .padding(.bottom, -20)
                    }
                    Spacer()
                }
            }.background(appSettings.isDarkMode ? Color.linearBlackColor : Color.linearWhiteColor)
                .navigationBarBackButtonHidden(true)
        }
        .sheet(isPresented: $showSignInSheet) {
            SignInPage()
        }
    }
    init() {
        liveScoreCardViewModel.getLiveScore()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .environmentObject(AppSettings())
    }
}

