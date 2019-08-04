//
//  WeatherForecastController.swift
//  LUCID WEATHER APP - iOLAP
//
//  Created by Mateo Doslic on 04/08/2019.
//  Copyright © 2019 Mateo Doslic. All rights reserved.
//

import Foundation
import CoreData
import UIKit

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
    
    
    func saveCurrentCity(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SavedWeather", in: context)
        let newWeather = NSManagedObject(entity: entity!, insertInto: context)
        
        newWeather.setValue(self.weather!.name , forKey: "cityName")
        newWeather.setValue(self.weather!.main!.humidity!, forKey: "humidity")
        newWeather.setValue(self.weather!.main!.pressure! , forKey: "pressure")
        newWeather.setValue(self.weather!.main!.temp! , forKey: "temperature")
        newWeather.setValue(self.weather!.name , forKey: "weatherDescription")
        newWeather.setValue(self.weather!.wind!.speed! , forKey: "windSpeed")
        
        
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM yyyy HH:mm"
        let formatedDate = dateformatter.string(from: date)
        newWeather.setValue(formatedDate , forKey: "date")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
