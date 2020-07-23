//
//  ViewController.swift
//  SBiOS_m12_dz
//
//  Created by Dmitry Aksyonov on 20.01.2020.
//  Copyright © 2020 Dmitry Aksyonov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - outlets and other properties
    @IBOutlet weak var mainDescription: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let weatherGetter = GetWeather()
    
    //MARK: - initial setting
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherGetter.getCurrenMowWeather { (data, status) in
            if let data = data, status {
            } else if status {
                print("****** Error Decoding Data ******")
            } else {
                print("****** Error Obtaining Data ******")
            }
            
            DispatchQueue.main.async {
                self.mainDescription.text = "\(data!.name): \(data!.weather.first?.description ?? "hmmm")"
                self.temperature.text = "\(NumberFormatter.localizedString(from: data!.main.temp as NSNumber, number: .none))°"
                self.minTemp.text = "\(NumberFormatter.localizedString(from: data!.main.temp_min as NSNumber, number: .none))°"
                self.maxTemp.text = "\(NumberFormatter.localizedString(from: data!.main.temp_max as NSNumber, number: .none))°"
                self.feelsLike.text = "\(NumberFormatter.localizedString(from: data!.main.feels_like as NSNumber, number: .none))°"
                self.pressure.text = "\(NumberFormatter.localizedString(from: data!.main.pressure as NSNumber, number: .decimal)) hPa"
                self.humidity.text = "\(NumberFormatter.localizedString(from: data!.main.humidity as NSNumber, number: .decimal)) %"
                self.windSpeed.text = "\(NumberFormatter.localizedString(from: data!.wind.speed as NSNumber, number: .decimal)) m/s"
            }
        }
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        self.dateLabel.text = "Today is: \(formattedDate)"
    }
}
