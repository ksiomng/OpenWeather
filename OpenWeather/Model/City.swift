//
//  City.swift
//  OpenWeather
//
//  Created by Song Kim on 10/21/24.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let coord: Coordinates
    
    struct Coordinates: Codable {
        let lon: Double
        let lat: Double
    }
}
