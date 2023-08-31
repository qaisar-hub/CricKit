//
//  customTabBar.swift
//  CricKit
//
//  Created by ephrim.daniel on 08/08/23.
//

import SwiftUI

struct customTabBar: View {
	@EnvironmentObject private var appSettings: AppSettings
    
    var tabs: [(tabName: String, imageName: String)] = [(tabName: "home", imageName: "house.fill"), (tabName: "shop", imageName: "cart.fill"), (tabName: "profile", imageName: "person.fill")]
    
    @Binding var selectedIndex: Int
    
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(tabs.enumerated().map({ $0 }), id: \.element.tabName) { index, tab in
                TabBarButton(tabName: tab.tabName, imageName: tab.imageName, tabIndex: index, selectedIndex: $selectedIndex)
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
	@EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        Button(action: {
            selectedIndex = tabIndex
        }) {
            VStack(spacing: 3) {
                Image(systemName: imageName)
                    .foregroundColor(selectedIndex == tabIndex ?  Color.appPrimary : appSettings.isDarkMode ? Color.white : Color.gray)
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
        customTabBar(selectedIndex: .constant(0))
    }
}
