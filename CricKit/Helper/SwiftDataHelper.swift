//
//  SwiftDataHelper.swift
//  CricKit
//
//  Created by Qaisar Raza on 11/09/23.
//

//import SwiftUI
//import SwiftData
//
//public class SwiftDataHelper {
//    static let shared = SwiftDataHelper()
//    
//    @EnvironmentObject private var appSettings: AppSettings
//    @Environment(\.modelContext) private var modelContext
//    @Query var userDataModel : [UserDataModel]
//    
//    private init() {}
//    
//    func addOrUpdateUserDataModel() {
//        if let existingUserIndex = userDataModel.firstIndex(where: { $0.id == "" }) {
//            userDataModel[existingUserIndex].isDarkMode = appSettings.isDarkMode
//            userDataModel[existingUserIndex].favouriteTeam = appSettings.favouriteTeam
//            do {
//                try modelContext.save()
//            } catch {
//                fatalError("Not saved")
//            }
//            debugPrint(userDataModel[existingUserIndex].isDarkMode)
//            debugPrint(userDataModel[existingUserIndex].favouriteTeam)
//        } else {
//            let userData = UserDataModel(isDarkMode: appSettings.isDarkMode, favouriteTeam: appSettings.favouriteTeam)
//            modelContext.insert(userData)
//        }
//        
//    }
//    
//}
