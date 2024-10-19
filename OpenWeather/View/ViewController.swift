//
//  ViewController.swift
//  OpenWeather
//
//  Created by Song Kim on 10/16/24.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate {
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sunny")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var textView: UITextView = {
        let text = UITextView()
        text.text = "Seoul"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.font = UIFont.systemFont(ofSize: 40)
        text.textAlignment = .center
        return text
    }()
    
    let cities = ["Seoul", "New York", "London", "Tokyo", "Paris", "Los Angeles", "Berlin", "Beijing", "Moscow"]
    var filteredCities: [String] = []
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupSearchController()
        
        filteredCities = cities
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(textView)
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 100),
            
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
        searchController.searchBar.placeholder = "Search Cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredCities = cities
            tableView.reloadData()
            return
        }
        
        filteredCities = cities.filter { city in
            city.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        textView.isHidden = true
        tableView.isHidden = false
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        textView.isHidden = false
        tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cityCell")
        cell.textLabel?.text = filteredCities[indexPath.row]
        cell.backgroundColor = UIColor.clear
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = filteredCities[indexPath.row]
        print("Selected city: \(selectedCity)")
    }
}
