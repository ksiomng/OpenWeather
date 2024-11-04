//
//  PrecipitationMapView.swift
//  OpenWeather
//
//  Created by Song Kim on 10/21/24.
//

import UIKit
import MapKit

class PrecipitationMapView: UIView {
    
    lazy var mapLabel: UILabel = {
        let label = UILabel()
        label.text = "지도"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var precipitationMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        addPrecipitationOverlay(to: mapView)
        return mapView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(named: "backgroundColor")
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mapLabel)
        addSubview(precipitationMapView)
        
        NSLayoutConstraint.activate([
            mapLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mapLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            precipitationMapView.topAnchor.constraint(equalTo: mapLabel.bottomAnchor, constant: 10),
            precipitationMapView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            precipitationMapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            precipitationMapView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    private func addPrecipitationOverlay(to mapView: MKMapView) {
        let template = "https://your_precipitation_tile_server/{z}/{x}/{y}.png"
        let overlay = MKTileOverlay(urlTemplate: template)
        overlay.canReplaceMapContent = false
        
        mapView.addOverlay(overlay)
    }
    
    func centerMapOnCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000) // 
        precipitationMapView.setRegion(region, animated: true)
    }
}
