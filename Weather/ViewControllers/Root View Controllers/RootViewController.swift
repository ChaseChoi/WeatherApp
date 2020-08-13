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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        let location = Location(longitude: Defaults.longitude, latitude: Defaults.latitude)
        dataManager.requestWeatherData(at: location) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                print(data)
            }
        }
    }
}
