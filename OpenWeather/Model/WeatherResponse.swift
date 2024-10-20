//
//  WeatherResponse.swift
//  OpenWeather
//
//  Created by Song Kim on 10/21/24.
//

import Foundation

struct WeatherResponse: Codable {
    let cod: Int // Change from String to Int
    let message: String?
    let city: City
    let list: [WeatherData]
}

struct WeatherData: Codable {
    let dt: Int
    let main: MainWeatherData
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dt_txt: String
}

struct MainWeatherData: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Rain: Codable {
    let threeHour: Double

    enum CodingKeys: String, CodingKey {
        case threeHour = "3h"
    }
}

struct Sys: Codable {
    let pod: String
}

struct CityData: Codable {
    let id: Int
    let name: String
    let coord: Coordinates
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}
