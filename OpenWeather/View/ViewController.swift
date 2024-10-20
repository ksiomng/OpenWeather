//
//  ViewController.swift
//  OpenWeather
//
//  Created by Song Kim on 10/16/24.
//

import UIKit

// WeatherDisplayView Class
class WeatherDisplayView: UIView {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityMainView, tempView, weatherView, maxminTempView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var cityMainView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isEditable = false
        text.isSelectable = false
        text.isScrollEnabled = false
        text.backgroundColor = .clear
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 40)
        text.textContainerInset = .zero
        text.textAlignment = .center
        return text
    }()
    
    lazy var tempView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isEditable = false
        text.isSelectable = false
        text.isScrollEnabled = false
        text.backgroundColor = .clear
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 90)
        text.textContainerInset = .zero
        text.textAlignment = .center
        return text
    }()
    
    lazy var weatherView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isEditable = false
        text.isSelectable = false
        text.isScrollEnabled = false
        text.backgroundColor = .clear
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 28)
        text.textContainerInset = .zero
        text.textAlignment = .center
        return text
    }()
    
    lazy var maxminTempView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isScrollEnabled = false
        text.backgroundColor = .clear
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 20)
        text.textContainerInset = .zero
        text.textAlignment = .center
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        stackView.addSubview(cityMainView)
        stackView.addSubview(tempView)
        stackView.addSubview(weatherView)
        stackView.addSubview(maxminTempView)

        NSLayoutConstraint.activate([
            cityMainView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 6),
            cityMainView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            cityMainView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            tempView.topAnchor.constraint(equalTo: cityMainView.bottomAnchor, constant: 7),
            tempView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            tempView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            weatherView.topAnchor.constraint(equalTo: tempView.bottomAnchor, constant: 4),
            weatherView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            maxminTempView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 2),
            maxminTempView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            maxminTempView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            maxminTempView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])

    }
    
    func updateWeatherInfo(city: String, temperature: String, weatherDescription: String, maxMinTemp: String) {
        cityMainView.text = city
        tempView.text = temperature
        weatherView.text = weatherDescription
        maxminTempView.text = maxMinTemp
    }
}

// ViewController Class
class ViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate {
    
    let viewModel = WeatherViewModel()
    var tableView: UITableView!
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sunny")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var mainView: WeatherDisplayView = {
        let view = WeatherDisplayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupSearchController()
        
        // Example of updating the weather info
        let city = "Seoul"
        let temperature = "-17°"
        let weatherDescription = "맑음"
        let maxMinTemp = "최고: -1°  | 최저: -10°"
        mainView.updateWeatherInfo(city: city, temperature: temperature, weatherDescription: weatherDescription, maxMinTemp: maxMinTemp)
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
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
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
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.filterCities(for: searchText)
        tableView.reloadData()
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        mainView.isHidden = true
        tableView.isHidden = false
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        mainView.isHidden = false
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
