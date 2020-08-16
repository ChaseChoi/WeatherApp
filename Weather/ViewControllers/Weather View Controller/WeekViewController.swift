//
//  WeekViewController.swift
//  Weather
//
//  Created by Chase Choi on 2020/8/16.
//  Copyright © 2020 Chase Choi. All rights reserved.
//

import UIKit

class WeekViewController: UITableViewController {
    
    private let cellID = "WeekViewCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

extension WeekViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "Hello World"
        return cell
    }
}

extension WeekViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

