//
//  ViewController.swift
//  Sunny
//
//  Created by Ivan Akulov on 24/02/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var networkManager = NetworkWeatherManager()

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) {[unowned self] city in
            self.networkManager.fetchCurrentWeather(forCity: city)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.fetchCurrentWeather(forCity: "Minsk")
        networkManager.onCompletion = { [weak self] curentWeather in
            guard let self = self else {return}
            self.updateInterfaceWith(weather: curentWeather)
        }
    }
    
    func updateInterfaceWith(weather: CurrentWeather){
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTempString
            self.weatherIconImageView.image = UIImage(systemName: weather.sysytemIconNameString)
        }
    }
}


