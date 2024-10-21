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
    var weatherResponse: [WeatherResponse] = []
    
    private let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
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
            print("Loaded cities: \(cities.count)")
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
    
    func fetchWeather(for city: City, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        guard let apiKey = apiKey else {
            print("API key not found.")
            completion(.failure(NSError(domain: "API key missing", code: -1, userInfo: nil)))
            return
        }
        
        let latitude = city.coord.lat
        let longitude = city.coord.lon
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received.")
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                print("Error decoding weather response: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
