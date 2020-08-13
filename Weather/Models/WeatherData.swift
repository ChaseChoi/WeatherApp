//
//  WeatherData.swift
//  Weather
//
//  Created by Chase Choi on 2020/8/12.
//  Copyright © 2020 Chase Choi. All rights reserved.
//

import Foundation

struct WeatherData {
    
    let latitude: Double
    let longitude: Double
    
    let summary: String
    let windSpeed: Double
    let temperature: Double
    let iconName: String
    
//    let dailyData: [WeatherData]
    
    enum TopLevelCodingKeys: String, CodingKey {
        case latitude
        case longitude
        case currently
    }
    
    enum CurrentlyWeatherCodingKeys: String, CodingKey {
        case summary
        case windSpeed
        case temperature
        case icon = "iconName"
    }
}

extension WeatherData: Decodable {
    init(from decoder: Decoder) throws {
        let topLevelValues = try decoder.container(keyedBy: TopLevelCodingKeys.self)
        let currentlyWeather = try topLevelValues.nestedContainer(keyedBy: CurrentlyWeatherCodingKeys.self, forKey: .currently)
        
        latitude = try topLevelValues.decode(Double.self, forKey: .latitude)
        longitude = try topLevelValues.decode(Double.self, forKey: .longitude)
        
        summary = try currentlyWeather.decode(String.self, forKey: .summary)
        windSpeed = try currentlyWeather.decode(Double.self, forKey: .windSpeed)
        
        temperature = try currentlyWeather.decode(Double.self, forKey: .temperature)
        iconName = try currentlyWeather.decode(String.self, forKey: .icon)
    }
}
