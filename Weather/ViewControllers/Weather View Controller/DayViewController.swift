//
//  DayViewController.swift
//  Weather
//
//  Created by Chase Choi on 2020/8/16.
//  Copyright © 2020 Chase Choi. All rights reserved.
//

import UIKit

class DayViewController: UIViewController {
    
    // MARK: - Properties
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, descriptionLabel, temperatureLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    var weatherData: WeatherData? {
        didSet {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(activityIndicatorView)
        view.addSubview(stackView)
    }
    
    private func setupLayout() {
        let layoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            activityIndicatorView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
        ])
    }
    
    private func updateUI() {
        guard let weatherData = weatherData else { return }
        
        activityIndicatorView.stopAnimating()
        
        descriptionLabel.text = weatherData.summary
        temperatureLabel.text = "\(weatherData.temperature)"
        let iconImage = UIImage(named: weatherData.iconName)?.withTintColor(.systemOrange)
        iconImageView.image = iconImage
    }
}
