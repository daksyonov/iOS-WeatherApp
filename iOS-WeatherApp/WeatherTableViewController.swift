//
//  WeatherTableViewController.swift
//  WeatherForecast
//
//  Created by Dmitry Aksyonov on 04.03.2020.
//  Copyright © 2020 Dmitry Aksyonov. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    @IBOutlet weak var tableV: UITableView!
    
    let weatherGetter = GetWeather()
    var tableData = [List]()
    
    let dateFormatter = DateFormatter()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableV.delegate = self
        tableV.dataSource = self
        
        weatherGetter.getMowForecast { (data, status) in
            if let data = data, status {
                self.tableData = data.list
                DispatchQueue.main.async {
                    self.tableV.reloadData()
                }
            } else if status {
                print("****** Error Decoding Data ******")
            } else {
                print("****** Error Obtaining Data ******")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let weatherData = self.tableData[indexPath.row]
        
        prepareDateFormatter()
        
        let date = Date(timeIntervalSince1970: TimeInterval(weatherData.dt))
        
        dateFormatter.string(from: date)
        
        cell.dateAndTimeLabel.text = "\(dateFormatter.string(from: date)), (\(weatherData.weather.first?.description ?? "nil"))"
        cell.tempLabel.text = "\(Int(weatherData.main.temp))°"
        
        return cell
    }
    
    func prepareDateFormatter() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMd HH:mm")
        
    }
    
}
