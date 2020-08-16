//
//  RootViewController.swift
//  Weather
//
//  Created by Chase Choi on 2020/8/13.
//  Copyright © 2020 Chase Choi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    private lazy var dataManager: DataManager = {
        DataManager(baseURL: API.authenticatedBaseURL)
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        return stackView
    }()
    
    let dayViewController = DayViewController()
    let weekViewController = WeekViewController()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        let location = Location(longitude: Defaults.longitude, latitude: Defaults.latitude)
        dataManager.requestWeatherData(at: location) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let weatherData):
                print(weatherData)
                self.dayViewController.weatherData = weatherData
            }
        }
    }
    
    private var initialSetupDone = false
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if !initialSetupDone {
            initialSetupDone = true
            configureConstraints(for: traitCollection.verticalSizeClass)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass {
            configureConstraints(for: traitCollection.verticalSizeClass)
        }
    }
    
    private func addContentController(childController: UIViewController, to stackView: UIStackView) {
        addChild(childController)
        stackView.addArrangedSubview(childController.view)
        childController.didMove(toParent: self)
    }
    
    private func setupView() {
        view.addSubview(stackView)
        
        addContentController(childController: dayViewController, to: stackView)
        addContentController(childController: weekViewController, to: stackView)
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func configureConstraints(for sizeClass: UIUserInterfaceSizeClass) {
        if sizeClass == .regular {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
    }
}
