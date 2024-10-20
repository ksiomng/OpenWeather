//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Song Kim on 10/20/24.
//

import Foundation

class WeatherViewModel {
    var cities: [String] = ["Seoul", "New York", "London", "Tokyo", "Paris", "Los Angeles", "Berlin", "Beijing", "Moscow"]
    var filteredCities: [String] = []
    
    init() {
        filteredCities = cities
    }
    
    func filterCities(for searchText: String) {
        if searchText.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter { city in
                city.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func selectedCity(at index: Int) -> String {
        return filteredCities[index]
    }
    
    func numberOfFilteredCities() -> Int {
        return filteredCities.count
    }
}
