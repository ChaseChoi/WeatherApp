//
//  WeekViewController.swift
//  Weather
//
//  Created by Chase Choi on 2020/8/16.
//  Copyright © 2020 Chase Choi. All rights reserved.
//

import UIKit

class WeekViewController: UITableViewController {
    
    var dailyData: [DailyWeatherData]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    let footerView = UIView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(WeekTableViewCell.self, forCellReuseIdentifier: WeekTableViewCell.reuseIdentifier)
        
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        view.addSubview(activityIndicatorView)
        tableView.tableFooterView = footerView
    }
    
    private func setupLayout() {
        let layoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            activityIndicatorView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
        ])
    }
}

extension WeekViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeekTableViewCell.reuseIdentifier, for: indexPath) as! WeekTableViewCell
        if let weatherData = dailyData {
            cell.weatherData = weatherData[indexPath.row]
        }
        return cell
    }
}

extension WeekViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyData?.count ?? 0
    }
}

