//
//  WatchViewModel.swift
//  CricKit For Watch Watch App
//
//  Created by gokul.krishnan on 18/09/23.
//

import Foundation
@MainActor
public class WatchViewModel: ObservableObject {
    @Published var liveMatches = Documents(documents: [Document]())
    @Published var isLoading = false
    
    init() {
        Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(self.fetchDataForWatch), userInfo: nil, repeats: true)
        fetchDataForWatch()
    }
    @objc func fetchDataForWatch() {
        guard let url = URL(string:"https://firestore.googleapis.com/v1/projects/crickit-655b9/databases/(default)/documents/liveMode?key=AIzaSyC-GC8IM7dJZKB1xWNQVhK1YUzod9InpvQ") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        isLoading = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                }
                print(error)
                return
            }
            if let data = data {
                do{
                    let decodedResponse = try JSONDecoder().decode(Documents.self, from: data)
                    DispatchQueue.main.async { [weak self] in
                        self?.liveMatches = decodedResponse
                        self?.isLoading = false
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
