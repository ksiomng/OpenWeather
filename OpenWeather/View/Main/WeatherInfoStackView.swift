//
//  WeatherInfoStackView.swift
//  OpenWeather
//
//  Created by Song Kim on 10/21/24.
//

import UIKit

class WeatherInfoStackView: UIView {
    
    private let humidityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "습도"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let HumidityView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cloudCoverageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "구름"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cloudCoverageValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let CloudCoverageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let windSpeedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "바람 속도"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windSpeedValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let WindSpeedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pressureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "기압"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pressureValueLabel: UILabel = {
        let label = UILabel()
        label.text = "1015 hPa"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let PressureView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(humidity: String, cloudCoverage: String, windSpeed: String, pressure: String) {
        super.init(frame: .zero)
        humidityValueLabel.text = humidity
        cloudCoverageValueLabel.text = cloudCoverage
        windSpeedValueLabel.text = windSpeed
        pressureValueLabel.text = pressure
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        HumidityView.addSubview(humidityTitleLabel)
        HumidityView.addSubview(humidityValueLabel)
        
        CloudCoverageView.addSubview(cloudCoverageTitleLabel)
        CloudCoverageView.addSubview(cloudCoverageValueLabel)
        
        WindSpeedView.addSubview(windSpeedTitleLabel)
        WindSpeedView.addSubview(windSpeedValueLabel)

        PressureView.addSubview(pressureTitleLabel)
        PressureView.addSubview(pressureValueLabel)
        
        addSubview(HumidityView)
        addSubview(CloudCoverageView)
        addSubview(WindSpeedView)
        addSubview(PressureView)
        
        NSLayoutConstraint.activate([
            HumidityView.topAnchor.constraint(equalTo: self.topAnchor),
            HumidityView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            HumidityView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.48),
            HumidityView.heightAnchor.constraint(equalToConstant: 160),
            
            humidityTitleLabel.topAnchor.constraint(equalTo: HumidityView.topAnchor, constant: 10),
            humidityTitleLabel.leadingAnchor.constraint(equalTo: HumidityView.leadingAnchor, constant: 10),
            
            humidityValueLabel.topAnchor.constraint(equalTo: humidityTitleLabel.bottomAnchor, constant: 40),
            humidityValueLabel.leadingAnchor.constraint(equalTo: HumidityView.leadingAnchor, constant: 10),
            
            CloudCoverageView.topAnchor.constraint(equalTo: self.topAnchor),
            CloudCoverageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            CloudCoverageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.48),
            CloudCoverageView.heightAnchor.constraint(equalToConstant: 160),
            
            cloudCoverageTitleLabel.topAnchor.constraint(equalTo: CloudCoverageView.topAnchor, constant: 10),
            cloudCoverageTitleLabel.leadingAnchor.constraint(equalTo: CloudCoverageView.leadingAnchor, constant: 10),
            
            cloudCoverageValueLabel.topAnchor.constraint(equalTo: cloudCoverageTitleLabel.bottomAnchor, constant: 40),
            cloudCoverageValueLabel.leadingAnchor.constraint(equalTo: CloudCoverageView.leadingAnchor, constant: 10),
            
            WindSpeedView.topAnchor.constraint(equalTo: HumidityView.bottomAnchor, constant: 20),
            WindSpeedView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            WindSpeedView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.48),
            WindSpeedView.heightAnchor.constraint(equalToConstant: 160),
            
            windSpeedTitleLabel.topAnchor.constraint(equalTo: WindSpeedView.topAnchor, constant: 10),
            windSpeedTitleLabel.leadingAnchor.constraint(equalTo: WindSpeedView.leadingAnchor, constant: 10),
            
            windSpeedValueLabel.topAnchor.constraint(equalTo: windSpeedTitleLabel.bottomAnchor, constant: 40),
            windSpeedValueLabel.leadingAnchor.constraint(equalTo: WindSpeedView.leadingAnchor, constant: 10),
            
            PressureView.topAnchor.constraint(equalTo: CloudCoverageView.bottomAnchor, constant: 20),
            PressureView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            PressureView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.48),
            PressureView.heightAnchor.constraint(equalToConstant: 160),
            
            pressureTitleLabel.topAnchor.constraint(equalTo: PressureView.topAnchor, constant: 10),
            pressureTitleLabel.leadingAnchor.constraint(equalTo: PressureView.leadingAnchor, constant: 10),
            
            pressureValueLabel.topAnchor.constraint(equalTo: pressureTitleLabel.bottomAnchor, constant: 40),
            pressureValueLabel.leadingAnchor.constraint(equalTo: PressureView.leadingAnchor, constant: 10),
        ])
    }
}
