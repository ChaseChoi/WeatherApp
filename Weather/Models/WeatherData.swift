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
    
    let dailyData: [DailyWeatherData]
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case currently
        case dailyData = "daily"
    }
    
    enum CurrentlyWeatherCodingKeys: String, CodingKey {
        case summary
        case windSpeed
        case temperature
        case iconName = "icon"
    }
    
    enum DailyWeatherCodingKeys: String, CodingKey {
        case data
    }
}

extension WeatherData: Decodable {
    init(from decoder: Decoder) throws {
        let topLevelValues = try decoder.container(keyedBy: CodingKeys.self)
        let currentlyWeather = try topLevelValues.nestedContainer(keyedBy: CurrentlyWeatherCodingKeys.self, forKey: .currently)
        let dailyWeather = try topLevelValues.nestedContainer(keyedBy: DailyWeatherCodingKeys.self, forKey: .dailyData)
        
        latitude = try topLevelValues.decode(Double.self, forKey: .latitude)
        longitude = try topLevelValues.decode(Double.self, forKey: .longitude)
        
        summary = try currentlyWeather.decode(String.self, forKey: .summary)
        windSpeed = try currentlyWeather.decode(Double.self, forKey: .windSpeed)
        
        temperature = try currentlyWeather.decode(Double.self, forKey: .temperature)
        iconName = try currentlyWeather.decode(String.self, forKey: .iconName)
        
        dailyData = try dailyWeather.decode([DailyWeatherData].self, forKey: .data)
    }
}

struct DailyWeatherData: Decodable {
    let time: Date
    let iconName: String
    let windSpeed: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case iconName = "icon"
        case windSpeed
        case temperatureMin
        case temperatureMax
    }
}


