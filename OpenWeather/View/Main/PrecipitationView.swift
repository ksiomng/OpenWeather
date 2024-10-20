//
//  PrecipitationView.swift
//  OpenWeather
//
//  Created by Song Kim on 10/21/24.
//
//
//import UIKit
//import MapKit
//
//class PrecipitationMapViewController: UIViewController {
//
//    private var mapView: MKMapView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Precipitation Map"
//        view.backgroundColor = UIColor(named: "backgroundColor")
//
//        setupMapView()
//        loadPrecipitationData()
//    }
//
//    private func setupMapView() {
//        mapView = MKMapView()
//        mapView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(mapView)
//
//        NSLayoutConstraint.activate([
//            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//
//    private func loadPrecipitationData() {
//        // Load and display precipitation data on the map
//        // Add overlay or annotations as needed
//        // Placeholder for precipitation data loading
//        let location = CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.978)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "Seoul"
//        mapView.addAnnotation(annotation)
//        mapView.setRegion(MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)
//    }
//}
