//
//  HttpNetworkService.swift
//  CricKit
//
//  Created by Qaisar Raza on 02/10/23.
//

import Foundation

enum FetchError: Error {
    case missingData
    case missingURL
    case unableToParse
    case responseError
}

protocol NetworkService {
    func fetchData<T:Codable>(from url: String, resultType: T.Type, completion: @escaping (Result<T?, FetchError>) -> Void)
}

class HttpNetworkService: NetworkService {
    func fetchData<T>(from url: String, resultType: T.Type, completion: @escaping (Result<T?, FetchError>) -> Void) where T : Decodable, T : Encodable {
        guard let url = URL(string: url) else {
            completion(.failure(.missingURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(.failure(.missingData))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            
            // Parse the JSON data
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                completion(.success(data))
            }
            catch {
                completion(.failure(.unableToParse))
            }
  
        }.resume()
    }
    
}



