//
//  HistoryController.swift
//  LUCID WEATHER APP - iOLAP
//
//  Created by Mateo Doslic on 04/08/2019.
//  Copyright © 2019 Mateo Doslic. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class HistoryController {
    
    
    var savedWeather: [SavedWeatherClass] = []
    
    func retrieveData() {
        self.savedWeather = []
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedWeather")
        
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
          var weather = SavedWeatherClass()
        do {
          
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "cityName") as! String)
                weather.cityName = data.value(forKey: "cityName") as! String
                weather.date = data.value(forKey: "date") as! String
                weather.humidity = data.value(forKey: "humidity") as! Int
                weather.pressure = data.value(forKey: "pressure") as! Int
                weather.temperature = data.value(forKey: "temperature") as! Double
                weather.weatherDescription = data.value(forKey: "weatherDescription") as! String
                weather.windSpeed = data.value(forKey: "windSpeed") as! Double
                
                self.savedWeather += [weather]
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
}
