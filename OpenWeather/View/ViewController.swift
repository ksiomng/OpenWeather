//
//  ViewController.swift
//  OpenWeather
//
//  Created by Song Kim on 10/16/24.
//

import UIKit

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
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cityMainView: UITextView = {
        let text = UITextView()
        text.text = "Seoul"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 40)
        text.textAlignment = .center
        return text
    }()
    
    lazy var tempView: UITextView = {
        let text = UITextView()
        text.text = "-17°"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 90)
        text.textAlignment = .center
        return text
    }()
    
    lazy var weatherView: UITextView = {
        let text = UITextView()
        text.text = "맑음"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 28)
        text.textAlignment = .center
        return text
    }()
    
    lazy var maxminTempView: UITextView = {
        let text = UITextView()
        text.text = "최고: -1°  | 최저: -10°"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 20)
        text.textAlignment = .center
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTopView()
        setupSearchController()
    }
    
    private func setupTopView() {
        mainView.addSubview(cityMainView)
        mainView.addSubview(tempView)
        mainView.addSubview(weatherView)
        mainView.addSubview(maxminTempView)
        
        NSLayoutConstraint.activate([
            cityMainView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 6),
            cityMainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            cityMainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            cityMainView.heightAnchor.constraint(equalToConstant: 50),

            tempView.topAnchor.constraint(equalTo: cityMainView.bottomAnchor, constant: 10),
            tempView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            tempView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            tempView.heightAnchor.constraint(equalToConstant: 100),
            
            weatherView.topAnchor.constraint(equalTo: tempView.bottomAnchor, constant: 10),
            weatherView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            weatherView.heightAnchor.constraint(equalToConstant: 45),
            
            maxminTempView.topAnchor.constraint(equalTo: weatherView.bottomAnchor),
            maxminTempView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            maxminTempView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            maxminTempView.heightAnchor.constraint(equalToConstant: 30),
        ])
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
            mainView.heightAnchor.constraint(equalToConstant: 270),
            
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
        cell.backgroundColor = UIColor.clear
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
