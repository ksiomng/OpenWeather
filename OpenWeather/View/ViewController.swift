//
//  ViewController.swift
//  OpenWeather
//
//  Created by Song Kim on 10/16/24.
//

import UIKit

// MARK: - WeatherDisplayView Class
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

// MARK: ViewController Class
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
    
    lazy var horizontalScrollView: HourlyWeatherScrollView = {
        let scrollView = HourlyWeatherScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupSearchController()
        
        let city = "Seoul"
        let temperature = "-17°"
        let weatherDescription = "맑음"
        let maxMinTemp = "최고: -1°  | 최저: -10°"
        mainView.updateWeatherInfo(city: city, temperature: temperature, weatherDescription: weatherDescription, maxMinTemp: maxMinTemp)
        
        for i in 1...10 {
            let title = "Item \(i)"
            let subtitle = "\(i)°"
            let image = UIImage(named: "01d")
            horizontalScrollView.addItem(image: image, title: title, subtitle: subtitle)
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
        view.addSubview(mainView)
        
        view.addSubview(horizontalScrollView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            horizontalScrollView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 20),
            horizontalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 120),
            
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

// MARK: - HourlyWeather
class HourlyWeatherScrollItemView: UIView {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    init(image: UIImage?, title: String, subtitle: String) {
        super.init(frame: .zero)
        iconImageView.image = image
        timeLabel.text = title
        temperatureLabel.text = subtitle
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(timeLabel)
        addSubview(iconImageView)
        addSubview(temperatureLabel)

        let itemWidth: CGFloat = 60
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: itemWidth),
            
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            iconImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),

            temperatureLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 7),
            temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

class HourlyWeatherScrollView: UIView {
    lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var windSpeedIndicator: UILabel = {
        let label = UILabel()
        label.text = "돌풍의 풍속은 최대 7m/s 입니다."
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        addSubview(view)
        view.addSubview(scrollView)
        view.addSubview(divider)
        view.addSubview(windSpeedIndicator)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            windSpeedIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            windSpeedIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            windSpeedIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            divider.topAnchor.constraint(equalTo: windSpeedIndicator.bottomAnchor, constant: 7),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            scrollView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 2),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    func addItem(image: UIImage?, title: String, subtitle: String) {
        let item = HourlyWeatherScrollItemView(image: image, title: title, subtitle: subtitle)
        stackView.addArrangedSubview(item)
    }
}

