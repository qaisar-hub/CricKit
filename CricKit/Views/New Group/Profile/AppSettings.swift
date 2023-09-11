//
//  AppSettings.swift
//  CricKit
//
//  Created by Qaisar Raza on 30/08/23.
//

import SwiftUI

class AppSettings: ObservableObject {
    @Published var isDarkMode = false
    @Published var favouriteTeam = FavouriteTeam(team: "India", teamFlag: "teamInd")
    @Published var emailID = ""
    
    init() {
        let currentColorScheme = UIScreen.main.traitCollection.userInterfaceStyle
        self.isDarkMode = currentColorScheme == .dark
    }
}

