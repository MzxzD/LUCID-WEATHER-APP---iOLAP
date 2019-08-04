//
//  CityNames.swift
//  LUCID WEATHER APP - iOLAP
//
//  Created by Mateo Doslic on 04/08/2019.
//  Copyright © 2019 Mateo Doslic. All rights reserved.
//
import Foundation

// MARK: - Cities
struct Cities: Codable {
    let city: [City]
    
    enum CodingKeys: String, CodingKey {
        case city = "City"
    }
}

// MARK: - City
struct City: Codable {
    let name: String
    let lon, lat: Double
}
