//
//  Configuration.swift
//  Weather
//
//  Created by Chase Choi on 2020/8/13.
//  Copyright © 2020 Chase Choi. All rights reserved.
//

import Foundation

enum API {
    static var baseURL = URL(string: "https://api.darksky.net/forecast")!
    
    static var apiKey: String {
        let weatherAPIKey = ProcessInfo.processInfo.environment["WEATHER_API_KEY"]
        return weatherAPIKey ?? ""
    }
    
    static var authenticatedBaseURL: URL {
        return baseURL.appendingPathComponent(apiKey)
    }
}
