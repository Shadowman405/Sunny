//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by Maxim Mitin on 21.12.21.
//  Copyright © 2021 Ivan Akulov. All rights reserved.
//

import Foundation

struct NetworkWeatherManager {
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    
    func fetchCurrentWeather(forCity: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(forCity)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJson(withData: data){
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func parseJson(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        
        do{
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {return nil}
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
