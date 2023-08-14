//
//  customTabBar.swift
//  CricKit
//
//  Created by ephrim.daniel on 08/08/23.
//

import SwiftUI

struct customTabBar: View {
    
    var tabs: [(tabName: String, imageName: String)] = [(tabName: "home", imageName: "house.fill"), (tabName: "shop", imageName: "cart.fill"), (tabName: "profile", imageName: "person.fill")]
    
    @Binding var selectedIndex: Int
    
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(tabs.enumerated().map({ $0 }), id: \.element.tabName) { index, tab in
                TabBarButton(tabName: tab.tabName, imageName: tab.imageName, tabIndex: index, selectedIndex: $selectedIndex)
            }
        }
        .background(Blur(style: .systemChromeMaterialDark))
        .cornerRadius(10)
        .shadow(color: Color.black, radius: 5)
    }
}

struct TabBarButton: View {
    let tabName: String
    let imageName: String
    let tabIndex: Int
    @Binding var selectedIndex: Int
    
    var body: some View {
        Button(action: {
            selectedIndex = tabIndex
        }) {
            VStack(spacing: 3) {
                Image(systemName: imageName)
                    .foregroundColor(selectedIndex == tabIndex ?  Color.appPrimary : Color.appWhites)
                Text(tabName.capitalized)
                    .font(.caption)
                    .foregroundColor(selectedIndex == tabIndex ? Color.appPrimary : Color.appWhites)
            }
            .padding(10)
            .shadow(color: Color.appBlacks, radius: 5)
        }
    }
}


struct customTabBar_Previews: PreviewProvider {
    static var previews: some View {
        customTabBar(selectedIndex: .constant(0))
    }
}
