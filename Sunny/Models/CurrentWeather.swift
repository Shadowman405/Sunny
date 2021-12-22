//
//  CurrentWeather.swift
//  Sunny
//
//  Created by Maxim Mitin on 22.12.21.
//  Copyright © 2021 Ivan Akulov. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return "\(temperature.rounded())"
    }
    
    let feelsLikeTemp: Double
    var feelsLikeTempString: String {
        return "\(feelsLikeTemp.rounded())"
    }
    
    let conditionCode: Int
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemp = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
