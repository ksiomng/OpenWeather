//
//  HourlyWeather.swift
//  OpenWeather
//
//  Created by Song Kim on 10/20/24.
//

import UIKit

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
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            
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
        let item = HourlyWeatherScrollViewCell(image: image, title: title, subtitle: subtitle)
        stackView.addArrangedSubview(item)
    }
    
    func clearItems() {
        stackView.arrangedSubviews.forEach { subview in
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}

class HourlyWeatherScrollViewCell: UIView {
    
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
