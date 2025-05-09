//
//  ViewController.swift
//  OpenWeather
//
//  Created by Song Kim on 10/16/24.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate {
    
    let viewModel = WeatherViewModel()
    var tableView: UITableView!
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var mainView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weatherDisplayView, horizontalScrollView, fiveDayWeatherView, precipitationMapView, weatherInfoStackView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var weatherDisplayView: WeatherDisplayView = {
        let view = WeatherDisplayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var horizontalScrollView: HourlyWeatherScrollView = {
        let scrollView = HourlyWeatherScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var fiveDayWeatherView: FiveDayWeatherView = {
        let view = FiveDayWeatherView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var precipitationMapView: PrecipitationMapView = {
        let view = PrecipitationMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var weatherInfoStackView: WeatherInfoStackView = {
        let view = WeatherInfoStackView(humidity: "50%", cloudCoverage: "20%", windSpeed: "10 km/h", pressure: "1013 hPa")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupSearchController()
        
        let seoul = City(id: 1835848, name: "Seoul", country: "KR", coord: City.Coordinates(lon: 126.9780, lat: 37.5665))
        fetchWeather(for: seoul)
        
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherDisplayView.topAnchor.constraint(equalTo: mainView.topAnchor),
            weatherDisplayView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            weatherDisplayView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            horizontalScrollView.topAnchor.constraint(equalTo: weatherDisplayView.bottomAnchor, constant: 20),
            horizontalScrollView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 120),
            
            fiveDayWeatherView.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 20),
            fiveDayWeatherView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            fiveDayWeatherView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            
            precipitationMapView.topAnchor.constraint(equalTo: fiveDayWeatherView.bottomAnchor, constant: 20),
            precipitationMapView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            precipitationMapView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            precipitationMapView.heightAnchor.constraint(equalToConstant: 350),
            
            weatherInfoStackView.topAnchor.constraint(equalTo: precipitationMapView.bottomAnchor, constant: 20),
            weatherInfoStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            weatherInfoStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            weatherInfoStackView.heightAnchor.constraint(equalToConstant: 350),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            textField.textColor = UIColor.white
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        }
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func addPrecipitationOverlay(to mapView: MKMapView) {
        let template = "https://your_precipitation_tile_server/{z}/{x}/{y}.png"
        let overlay = MKTileOverlay(urlTemplate: template)
        overlay.canReplaceMapContent = false
        
        mapView.addOverlay(overlay)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.filterCities(for: searchText)
        tableView.reloadData()
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        mainView.isHidden = true
        scrollView.isHidden = true
        tableView.isHidden = false
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        mainView.isHidden = false
        scrollView.isHidden = false
        tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFilteredCities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cityCell")
        let city = viewModel.filteredCities[indexPath.row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = city.country
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .lightGray
        cell.backgroundColor = UIColor(named: "backgroundColor")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = viewModel.selectedCity(at: indexPath.row)
        if let searchController = navigationItem.searchController {
            searchController.isActive = false
        }
        fetchWeather(for: selectedCity)
    }
    
    private func fetchWeather(for city: City) {
        viewModel.fetchWeather(for: city) { [weak self] result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self?.updateWeatherDisplay(with: weatherResponse)
                }
            case .failure(let error):
                print("Failed to fetch weather data: \(error)")
            }
        }
    }
    
    private func updateWeatherDisplay(with weatherResponse: WeatherResponse) {
        guard let weatherData = weatherResponse.list.first else {
            print("No weather data available.")
            return
        }
        
        let city = weatherResponse.city.name
        let temperature = String(format: "%.1f°", weatherData.main.temp - 273.15)
        let weatherDescription = weatherData.weather.first?.description ?? ""
        let maxMinTemp = "최고: \(String(format: "%.2f°", weatherData.main.temp_max - 273.15)) | 최저: \(String(format: "%.2f°", weatherData.main.temp_min - 273.15))"
        
        weatherDisplayView.updateWeatherInfo(city: city, temperature: temperature, weatherDescription: weatherDescription, maxMinTemp: maxMinTemp)
        
        let humidity = "\(weatherData.main.humidity) %"
        let cloudCoverage = "\(weatherData.clouds.all) %"
        let windSpeed = "\(weatherData.wind.speed) km/h"
        let pressure = "\(weatherData.main.pressure) hPa"
        
        self.weatherInfoStackView.updateValues(humidity: humidity, cloudCoverage: cloudCoverage, windSpeed: windSpeed, pressure: pressure)
        
        let cityCoordinates = weatherResponse.city.coord
        if let precipitationMapView = mainView.subviews.compactMap({ $0 as? PrecipitationMapView }).first {
            precipitationMapView.centerMapOnCoordinates(latitude: cityCoordinates.lat, longitude: cityCoordinates.lon)
        }
        
        horizontalScrollView.clearItems()
        for weather in weatherResponse.list {
            let dateTime = weather.dt_txt
            let time = String(dateTime.suffix(8).prefix(2))
            let temperature = String(format: "%.1f°", weather.main.temp - 273.15)
            let icon = UIImage(named: weather.weather.first?.icon ?? "01d")
            
            horizontalScrollView.addItem(image: icon, title: time, subtitle: temperature)
        }
        
        fiveDayWeatherView.clearItems()
        var beforedate = ""
        var dayCounter = 0
        
        for weather in weatherResponse.list {
            let dateTime = weather.dt_txt
            let date = String(dateTime.prefix(10))
            
            if beforedate != date && dayCounter < 5 {
                beforedate = date
                dayCounter += 1
                
                let temperature = String(format: "%.1f°", weather.main.temp - 273.15)
                let icon = UIImage(named: weather.weather.first?.icon ?? "01d")
                let minTemp = String(format: "%.1f°", weather.main.temp_min - 273.15)
                let maxTemp = String(format: "%.1f°", weather.main.temp_max - 273.15)
                
                let cell = FiveDayWeatherViewCell(image: icon, date: date, minTemp: minTemp, maxTemp: maxTemp)
                fiveDayWeatherView.addCell(cell)
            }
        }
        
        horizontalScrollView.maxWindSpeed = weatherData.wind.speed
        
        let backgroundImage = (weatherData.weather.first?.main ?? "").lowercased()
        imageView.image = UIImage(named: backgroundImage)
    }
}
