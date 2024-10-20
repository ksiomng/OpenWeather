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
        image.image = UIImage(named: "sunny")
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
    
    lazy var weatherInfoStackView: UIView = {
        let humidity = "60%"
        let cloudCoverage = "20%"
        let windSpeed = "15 km/h"
        let pressure = "1015 hPa"
        
        let view = WeatherInfoStackView(humidity: humidity, cloudCoverage: cloudCoverage, windSpeed: windSpeed, pressure: pressure)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupSearchController()
        
        let city = "Seoul"
        let temperature = "-7°"
        let weatherDescription = "맑음"
        let maxMinTemp = "최고: -1°  | 최저: -11°"
        weatherDisplayView.updateWeatherInfo(city: city, temperature: temperature, weatherDescription: weatherDescription, maxMinTemp: maxMinTemp)
        
        for i in 1...10 {
            let title = "Item \(i)"
            let subtitle = "\(i)°"
            let image = UIImage(named: "01d")
            horizontalScrollView.addItem(image: image, title: title, subtitle: subtitle)
        }
        
        for i in 1...5 {
            let date = "Day \(i)"
            let minTemp = "\(10 - i)°"
            let maxTemp = "\(15 - i)°"
            let image = UIImage(named: "01d")
            let cell = FiveDayWeatherViewCell(image: image, date: date, minTemp: minTemp, maxTemp: maxTemp)
            fiveDayWeatherView.addCell(cell)
        }
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cityCell")
        cell.textLabel?.text = viewModel.filteredCities[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(named: "backgroundColor")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = viewModel.selectedCity(at: indexPath.row)
        print("Selected city: \(selectedCity)")
    }
}
