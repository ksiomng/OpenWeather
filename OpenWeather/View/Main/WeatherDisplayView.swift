//
//  WeatherDisplayView.swift
//  OpenWeather
//
//  Created by Song Kim on 10/20/24.
//

import UIKit

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
