//
//  FiveDayWeatherView.swift
//  OpenWeather
//
//  Created by Song Kim on 10/20/24.
//

import UIKit

class FiveDayWeatherView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var fiveDaysLabel: UILabel = {
        let label = UILabel()
        label.text = "5일간의 일기예보"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        addSubview(fiveDaysLabel)
        
        NSLayoutConstraint.activate([
            fiveDaysLabel.topAnchor.constraint(equalTo: self.topAnchor),
            fiveDaysLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            fiveDaysLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            fiveDaysLabel.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: fiveDaysLabel.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func addCell(_ cell: FiveDayWeatherViewCell) {
        stackView.addArrangedSubview(cell)
    }
    
    func clearItems() {
        stackView.arrangedSubviews.forEach { subview in
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}

class FiveDayWeatherViewCell: UIView {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    init(image: UIImage?, date: String, minTemp: String, maxTemp: String) {
        super.init(frame: .zero)
        iconImageView.image = image
        dateLabel.text = date
        minTempLabel.text = "최소: \(minTemp)"
        maxTempLabel.text = "최대: \(maxTemp)"
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(dateLabel)
        addSubview(iconImageView)
        addSubview(minTempLabel)
        addSubview(maxTempLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            iconImageView.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            minTempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 240),
            minTempLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            
            maxTempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 290),
            maxTempLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor)
        ])
    }
}
