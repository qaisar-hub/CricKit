//
//  NewsViewModel.swift
//  CricKit
//
//  Created by Qaisar Raza on 09/09/23.
//

import Foundation

class NewsViewModel : ObservableObject {
    @Published var newsModel = [NewsModel]()
    
    func getaNewsData() {
        let parentCollection = FSCollectionManager.getCollectionID(collection: .news)
        FbDataServiceManager.shared.getData(parentCollection: parentCollection) { [self] snapshot in
            if let documents = snapshot?.documents {
                self.newsModel.removeAll()
                self.newsModel = documents.compactMap { document in
                    let data = document.data()
                    let imageName = data["imageName"] as? String ?? ""
                    let header = data["header"] as? String ?? ""
                    let subheader = data["subheader"] as? String ?? ""
                    return NewsModel(imageName: imageName, header: header, subheader: subheader)
                }
            }
        }
    }
}
