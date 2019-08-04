//
//  WeatherForecastController.swift
//  LUCID WEATHER APP - iOLAP
//
//  Created by Mateo Doslic on 04/08/2019.
//  Copyright © 2019 Mateo Doslic. All rights reserved.
//

import Foundation

class WeatherForecastController {
    let alamofireNetwork = AlamofireNetwork()
    var cityName: String = ""
    var weather: Weather?
    
    func fetchWeatherDataFromAPI(completion:@escaping (Weather)-> Void) {
        print(self.cityName)
        if self.cityName != "" {
            self.alamofireNetwork.requestWeatherViaCityName(CityName: cityName) { (weather) in
                completion(weather)
            }
        } else {
            print("Error in sending data from one view to another")
        }
     
    }
}
