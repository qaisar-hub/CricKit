//
//  AppSettings.swift
//  CricKit
//
//  Created by Qaisar Raza on 30/08/23.
//

import SwiftUI

@MainActor
class AppSettings: ObservableObject {
    
    @Published var isDarkMode = false
    @Published var favouriteTeam = FavouriteTeam(team: "India", teamFlag: "teamInd")
    @Published var userImage: Data? = nil
    @Published var showSkipButton = true
    
    
    func resetToInitialState() {
        favouriteTeam = FavouriteTeam(team: "India", teamFlag: "teamInd")
        userImage = nil
        showSkipButton = true
    }
    
    func updateExistingUserPreference(_ emailID: String) {
        if !emailID.isEmpty {
            SwiftDataHelper.shared.updateExistingUserPreference(emailID: emailID, isDarkMode: &isDarkMode, favouriteTeam: &favouriteTeam, userImage: &userImage)
        }
    }
    
    func addOrUpdateUserDataModel(_ emailID: String) {
        if !emailID.isEmpty {
            SwiftDataHelper.shared.addOrUpdateUserDataModel(emailID: emailID, isDarkMode: isDarkMode, favouriteTeam: favouriteTeam, userImage: userImage)
        }
    }
    
    func deleteUserPreference(_ emailID: String) {
        if !emailID.isEmpty {
            SwiftDataHelper.shared.deleteUserPreference(emailID: emailID)
        }
    }
    
}

