//
//  customTabBar.swift
//  CricKit
//
//  Created by ephrim.daniel on 08/08/23.
//

import SwiftUI

struct customTabBar: View {
	@EnvironmentObject private var appSettings: AppSettings
    @Binding var showSignInSheet: Bool

    
    var tabs: [(tabName: String, imageName: String)] = [(tabName: "home", imageName: "house.fill"), (tabName: "Live Mode", imageName: "livephoto"), (tabName: "profile", imageName: "person.fill")]
    
    @Binding var selectedIndex: Int
    
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(tabs.enumerated().map({ $0 }), id: \.element.tabName) { index, tab in
                TabBarButton(tabName: tab.tabName, imageName: tab.imageName, tabIndex: index, selectedIndex: $selectedIndex, showSignInSheet: $showSignInSheet)
            }
        }
		.background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
        .cornerRadius(10)
		.shadow(color: appSettings.isDarkMode ? Color.black : Color.white, radius: 0.5)
    }
}

struct TabBarButton: View {
    let tabName: String
    let imageName: String
    let tabIndex: Int
    @Binding var selectedIndex: Int
    @Binding var showSignInSheet: Bool
    @EnvironmentObject private var authViewModel: AuthViewModel
	@EnvironmentObject private var appSettings: AppSettings
    @State private var isAnimating: [Bool?] = [nil, nil, nil]
    
    var body: some View {
        Button(action: {
            if authViewModel.currentUser == nil && tabIndex == 2 {
                withAnimation {
                    appSettings.showSkipButton = false
                    showSignInSheet = true
                }
            } else {
                selectedIndex = tabIndex
                withAnimation(.bouncy ,completionCriteria: .logicallyComplete) {
                    isAnimating[selectedIndex] = true
                } completion: {
                    var trasnaction = Transaction()
                    trasnaction.disablesAnimations = true
                    withTransaction (trasnaction) {
                       isAnimating[selectedIndex] = nil
                    }
                }
                    
           }
        }) {
            VStack(spacing: 3) {
                Image(systemName: imageName)
                    .foregroundColor(selectedIndex == tabIndex ?  Color.appPrimary : appSettings.isDarkMode ? Color.white : Color.gray)
                    .symbolEffect(.bounce.down.byLayer, value: isAnimating[selectedIndex])
                Text(tabName.capitalized)
                    .font(.caption)
                    .foregroundColor(selectedIndex == tabIndex ? Color.appPrimary : appSettings.isDarkMode ? Color.white : Color.gray)
            }
            .padding(10)
			.shadow(color: appSettings.isDarkMode ? Color.black : Color.white, radius: 0.5)
        }
    }
}


struct customTabBar_Previews: PreviewProvider {
    static var previews: some View {
        customTabBar(showSignInSheet: .constant(false), selectedIndex: .constant(0))
    }
}
