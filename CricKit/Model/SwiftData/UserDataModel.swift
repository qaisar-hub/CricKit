//
//  UserData.swift
//  CricKit
//
//  Created by Qaisar Raza on 11/09/23.
//

import Foundation
import SwiftData

@Model
final class UserDataModel {

    @Attribute(.unique) var uniqueID: String
    var isDarkMode: Bool
    var favouriteTeam: FavouriteTeam
    
    init(uniqueID: String, isDarkMode: Bool, favouriteTeam: FavouriteTeam) {
        self.uniqueID = uniqueID
        self.isDarkMode = isDarkMode
        self.favouriteTeam = favouriteTeam
    }
}

extension UserDataModel {
    static func == (lhs: UserDataModel, rhs: UserDataModel) -> Bool {
        return lhs.uniqueID == rhs.uniqueID && lhs.isDarkMode == rhs.isDarkMode && lhs.favouriteTeam == rhs.favouriteTeam
        }
    
        func hash(into hasher: inout Hasher) {
            hasher.combine(uniqueID)
            hasher.combine(isDarkMode)
            hasher.combine(favouriteTeam)
        }
}
