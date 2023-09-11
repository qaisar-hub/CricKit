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
    
    var id: UUID
    var isDarkMode: Bool
    var favouriteTeam: FavouriteTeam
    
    init(id: UUID = UUID(), isDarkMode: Bool, favouriteTeam: FavouriteTeam) {
        self.id = id
        self.isDarkMode = isDarkMode
        self.favouriteTeam = favouriteTeam
    }
}

extension UserDataModel {
    static func == (lhs: UserDataModel, rhs: UserDataModel) -> Bool {
        return lhs.isDarkMode == rhs.isDarkMode && lhs.favouriteTeam == rhs.favouriteTeam
        }
    
        func hash(into hasher: inout Hasher) {
            hasher.combine(isDarkMode)
            hasher.combine(favouriteTeam)
        }
}
