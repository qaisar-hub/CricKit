//
//  RankingViewModel.swift
//  CricKit
//
//  Created by Qaisar Raza on 22/09/23.
//

import Foundation

class RankingViewModel: ObservableObject {
    @Published var category: RankingCategory?
    
    func fetchRankings(_ matchFormat: String) {
        debugPrint("matchFormat \(matchFormat)")
        guard let url = URL(string: "https://raw.githubusercontent.com/qaisar-hub/ranking/main/\(matchFormat).json") else {
            debugPrint("url is missing")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let decodedData = try? decoder.decode(RankingResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.category = decodedData.category
                    }
                } else {
                    debugPrint("error: \(String(describing: error?.localizedDescription))")
                }
            } else {
                debugPrint("error: \(String(describing: error?.localizedDescription))")
            }
        }.resume()
    }
}
