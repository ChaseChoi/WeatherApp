//
//  WeekTableViewCell.swift
//  Weather
//
//  Created by Chase Choi on 2020/8/16.
//  Copyright © 2020 Chase Choi. All rights reserved.
//

import UIKit

class WeekTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "WeekViewCell"
    
    var weatherData: DailyWeatherData? {
        didSet {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let temperatureRangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayLabel, iconImageView, temperatureRangeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let dayFormatter: DateFormatter = {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEE"
        return dayFormatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            stackView.heightAnchor.constraint(equalToConstant: 30),
            stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func updateUI() {
        guard let weatherData = weatherData else {
            return
        }
        iconImageView.image = UIImage(named: weatherData.iconName)?.withTintColor(.systemOrange)
        
        dayLabel.text = dayFormatter.string(from: weatherData.time)
        
        let temperatureMin = String(format:"%.f", weatherData.celciusTemperatureMin)
        let temperatureMax = String(format:"%.f", weatherData.celciusTemperatureMax)

        let opacityAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label.withAlphaComponent(0.5)
        ]
        
        let maxString = NSMutableAttributedString(string: temperatureMax)
        let minString = NSMutableAttributedString(string: "  \(temperatureMin)", attributes: opacityAttributes)
        maxString.append(minString)
        
        temperatureRangeLabel.attributedText = maxString
    }
}
