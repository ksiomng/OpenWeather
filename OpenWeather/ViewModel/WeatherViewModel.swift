//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Song Kim on 10/20/24.
//

import Foundation

class WeatherViewModel {
    var cities: [City] = []
    var filteredCities: [City] = []

    init() {
        loadCities()
        filteredCities = cities
    }
    
    private func loadCities() {
        guard let url = Bundle.main.url(forResource: "citylist", withExtension: "json") else {
            print("City list JSON file not found.")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            cities = try JSONDecoder().decode([City].self, from: data)
            print("Loaded cities: \(cities)")
        } catch {
            print("Error loading cities: \(error)")
        }
    }

    func filterCities(for query: String) {
        if query.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }

    func numberOfFilteredCities() -> Int {
        return filteredCities.count
    }

    func selectedCity(at index: Int) -> City {
        return filteredCities[index]
    }
}
