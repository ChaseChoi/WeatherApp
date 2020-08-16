//
//  DataManager.swift
//  Weather
//
//  Created by Chase Choi on 2020/8/13.
//  Copyright © 2020 Chase Choi. All rights reserved.
//

import UIKit

enum DataManagerError: Error {
    case unknown
    case failed
    case invalidResponse
}

class DataManager {
    typealias WeatherDataCompletion = (Result<WeatherData, DataManagerError>) -> Void
    
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func requestWeatherData(at location: Location, completion: @escaping WeatherDataCompletion) {
        let url = baseURL.appendingPathComponent("\(location.latitude),\(location.longitude)")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.failed))
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let weatherData = try decoder.decode(WeatherData.self, from: data)
                        completion(.success(weatherData))
                    } catch {
                        completion(.failure(.invalidResponse))
                    }
                } else {
                    completion(.failure(.invalidResponse))
                }
                
            } else {
                completion(.failure(.unknown))
            }
        }.resume()
    }
}
