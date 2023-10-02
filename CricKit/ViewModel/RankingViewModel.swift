//
//  RankingViewModel.swift
//  CricKit
//
//  Created by Qaisar Raza on 22/09/23.
//

import Foundation

class RankingViewModel: ObservableObject {
    @Published var category: RankingCategory?
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = HttpNetworkService()) {
        self.networkService = networkService
    }
    
    func fetchRankings(_ matchFormat: String) {
        let urlString = "https://raw.githubusercontent.com/qaisar-hub/ranking/main/\(matchFormat).json"
        
        networkService.fetchData(from: urlString, resultType: RankingResponse.self) { result in
            switch result{
            case .failure(let error):
                if error == .missingData {
                    print("data is missing")
                }
                if error == .missingURL {
                    print("url is missing")
                }
            case .success(let data):
                guard let data = data else {
                    return
                }
                //NetworkManager called on background thread
                //so we are moving to main thread before updating the UI
                DispatchQueue.main.async {
                    self.category = data.category
                }
            }
        }
    }
}
