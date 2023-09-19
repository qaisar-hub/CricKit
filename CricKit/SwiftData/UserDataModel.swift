//
//  UserData.swift
//  CricKit
//
//  Created by Qaisar Raza on 11/09/23.
//

import Foundation
import SwiftData
import UIKit

@Model
final class UserDataModel {

    @Attribute(.unique) var uniqueID: String
    var isDarkMode: Bool
    var favouriteTeam: FavouriteTeam
    @Attribute(.externalStorage) var userImage: Data?
    
    init(uniqueID: String, isDarkMode: Bool, favouriteTeam: FavouriteTeam, userImage: Data? = nil) {
        self.uniqueID = uniqueID
        self.isDarkMode = isDarkMode
        self.favouriteTeam = favouriteTeam
        self.userImage = userImage
    }

}

extension UserDataModel {
    static func == (lhs: UserDataModel, rhs: UserDataModel) -> Bool {
        return lhs.uniqueID == rhs.uniqueID && lhs.isDarkMode == rhs.isDarkMode && lhs.favouriteTeam == rhs.favouriteTeam && lhs.userImage == rhs.userImage
        }
    
        func hash(into hasher: inout Hasher) {
            hasher.combine(uniqueID)
            hasher.combine(isDarkMode)
            hasher.combine(favouriteTeam)
            hasher.combine(userImage)
        }
}
