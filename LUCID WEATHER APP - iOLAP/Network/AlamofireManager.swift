//
//  AlamofireManager.swift
//  LUCID WEATHER APP - iOLAP
//
//  Created by Mateo Doslic on 03/08/2019.
//  Copyright © 2019 Mateo Doslic. All rights reserved.
//

import Foundation
import Alamofire


class AlamofireNetwork {
    let ApiKey = "a40b8d50d2b07eb809d34280d0e5025e"
    let baseURL = "http://api.openweathermap.org/data/2.5/weather?"
    let lat = "lat="
    let log = "&lon="
    let appID = "&APPID="
    
    func requestDataFromAPI(log: Double, lat: Double, completion:@escaping (Weather)-> Void) {
        let url = self.baseURL + self.lat + String(lat) + self.log + String(log) + self.appID + self.ApiKey
        
        Alamofire.request(url)
            .responseJSON { (response) in
                guard response.result.error == nil else {
                    print("Error calling")
                    print(response.result.error)
                    return
                }
                
                let decoder = JSONDecoder()
                print(response)
                do {
                    let data = try decoder.decode(Weather.self, from: response.data!)
                    completion(data)
                }catch let error {
                    print(error.localizedDescription)
                }
        }
    }
}
