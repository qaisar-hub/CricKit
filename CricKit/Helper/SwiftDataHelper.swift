//
//  SwiftDataHelper.swift
//  CricKit
//
//  Created by Qaisar Raza on 11/09/23.
//

import SwiftUI
import SwiftData

@MainActor
public class SwiftDataHelper {
    static let shared = SwiftDataHelper()
    
    let container = createModelContainer()
    @Query var userDataModel : [UserDataModel]
    
    private init() {}
    
    func addOrUpdateUserDataModel(emailID: String, isDarkMode: Bool, favouriteTeam: FavouriteTeam, userImage: Data?) {
        do {
            let modelContext = container.mainContext
            let userDataModel = try modelContext.fetch(FetchDescriptor<UserDataModel>())
            if let existingUserIndex = userDataModel.firstIndex(where: { $0.uniqueID == emailID }) {
                debugPrint("### existingUserIndex \(existingUserIndex)")
                userDataModel[existingUserIndex].isDarkMode = isDarkMode
                userDataModel[existingUserIndex].favouriteTeam = favouriteTeam
                userDataModel[existingUserIndex].userImage = userImage
                debugPrint(userDataModel[existingUserIndex].isDarkMode)
                debugPrint(userDataModel[existingUserIndex].favouriteTeam)
            } else {
                let userData = UserDataModel(uniqueID: emailID, isDarkMode: isDarkMode, favouriteTeam: favouriteTeam, userImage: userImage)
                modelContext.insert(userData)
            }
            debugPrint("### userDataModel count : \(userDataModel.count)")
        } catch {
            debugPrint("### Error : \(error.localizedDescription)")
        }
        
    }
    
    func updateExistingUserPreference(emailID: String, isDarkMode: inout Bool , favouriteTeam: inout FavouriteTeam, userImage: inout Data?) {
        do {
            let modelContext = container.mainContext
            let userDataModel = try modelContext.fetch(FetchDescriptor<UserDataModel>())
            debugPrint("### emailID : \(emailID)")
            debugPrint("### userDataModel count : \(userDataModel.count)")
            if let existingUser = userDataModel.first(where: { $0.uniqueID == emailID }) {
                isDarkMode = existingUser.isDarkMode
                favouriteTeam = existingUser.favouriteTeam
                userImage = existingUser.userImage
                debugPrint("### isDarkMode : \(existingUser.isDarkMode)")
                debugPrint("### favouriteTeam : \(existingUser.favouriteTeam)")
            }
        } catch {
            debugPrint("### Error : \(error.localizedDescription)")
        }
    }
    
}

@MainActor
fileprivate func createModelContainer() -> ModelContainer {
     do {
        let container = try ModelContainer(for: UserDataModel.self)
         return container
    } catch let error {
        fatalError(error.localizedDescription)
    }
}
