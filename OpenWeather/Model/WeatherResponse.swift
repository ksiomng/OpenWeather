//
//  WeatherResponse.swift
//  OpenWeather
//
//  Created by Song Kim on 10/21/24.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Place
    let name: String // Replace city with name
    let weather: [Weather]
    let main: MainWeatherData
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
    let dt: Int
    let visibility: Int
}

struct Place: Codable {
    let lon: Double
    let lat: Double
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

struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}
