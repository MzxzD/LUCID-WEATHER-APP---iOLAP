//
//  WeatherForecastViewController.swift
//  LUCID WEATHER APP - iOLAP
//
//  Created by Mateo Doslic on 03/08/2019.
//  Copyright © 2019 Mateo Doslic. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController {
    
    @IBOutlet weak var temperatureSegmentController: UISegmentedControl!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    let controller = WeatherForecastController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SegmentControllerChanged(_ sender: Any) {
        guard let weatherTemperature = self.controller.weather?.main?.temp else {
            return
        }
        switch temperatureSegmentController.selectedSegmentIndex {
        case 0:
            print("celsius")
            self.temperatureLabel.text = String(round(100 * (weatherTemperature - 273.15))/100) + ""
        case 1:
            self.temperatureLabel.text = String(round(100 * (weatherTemperature * 9/5 - 459.67)) / 100) + ""
            print("ferenheit")
        default:
            print("nada")
        }
        
    }
    

    func setupView() {
        self.controller.fetchWeatherDataFromAPI() { (weather) in
            self.controller.weather = weather
            self.cityNameLabel.text = weather.name
            self.descriptionLabel.text = weather.weather!.first?.weatherDescription
            self.humidityLabel.text = String(weather.main!.humidity!) + " %"
            self.pressureLabel.text = String(weather.main!.pressure!) + " hPA"
            self.temperatureLabel.text = String(round(100 * (weather.main!.temp! - 273.15)) / 100) + ""
            self.windSpeedLabel.text = String(weather.wind!.speed!) + " km/h"
        }
    }
}
