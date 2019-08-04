//
//  CityNameController.swift
//  LUCID WEATHER APP - iOLAP
//
//  Created by Mateo Doslic on 04/08/2019.
//  Copyright © 2019 Mateo Doslic. All rights reserved.
//

import Foundation

class CityNameController {
    var cityNames: Cities?
    
    func fetchLocalData() {
        self.cityNames = loadJson(filename: "Cities")
    }
    
   private func loadJson(filename fileName: String) -> Cities? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Cities.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
