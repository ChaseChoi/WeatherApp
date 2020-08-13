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
    
    func fetchWeatherData(completion: @escaping WeatherDataCompletion) {
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            
        }
    }
}
