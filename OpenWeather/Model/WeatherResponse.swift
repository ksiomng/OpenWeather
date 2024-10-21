//
//  WeatherResponse.swift
//  OpenWeather
//
//  Created by Song Kim on 10/21/24.
//

import Foundation

struct WeatherResponse: Codable {
    let city: CityInfo
    let list: [WeatherData]
}

struct CityInfo: Codable {
    let id: Int
    let name: String
    let coord: Coordinates
    let country: String
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

struct WeatherData: Codable {
    let dt: Int
    let main: MainWeather
    let weather: [WeatherCondition]
    let clouds: CloudInfo
    let wind: WindInfo
    let dt_txt: String
}

struct MainWeather: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct WeatherCondition: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct CloudInfo: Codable {
    let all: Int
}

struct WindInfo: Codable {
    let speed: Double
    let deg: Int
}
