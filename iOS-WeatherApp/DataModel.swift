//
//  DataModel.swift
//  WeatherForecast
//
//  Created by Dmitry Aksyonov on 04.03.2020.
//  Copyright © 2020 Dmitry Aksyonov. All rights reserved.
//
//  DISCLAIMER: code styling is arbitrary.
//

import Foundation

// MARK: - Container for data representation

/**
  * This struct holds the data that will be presented in a table view
  * It is stored as an array
*/

struct WeatherForecast: Codable {
    var list: [List]
}


// MARK: - Data Structures

/**
  * Data structures are arranged as the are in initial JSON request:
  * https://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=b3d57a41f87619daf456bfefa990fce4&units=metric
  * View orginal JSON  at https://codebeautify.org/jsonviewer
  * Data structures remodel some of the JSON data to show weather forecast for Moscow with a 3-hours incremetn
  * Items to show are - date, time, min and max temperature
  * Structures conform to 'Codable' protocol
*/

struct List: Codable {
    var dt: Int
    var main: Main
    var weather: [Weather]
    var wind: Wind
}

        struct Main: Codable{
            var temp: Double
            var feels_like: Double
            var temp_min: Double
            var temp_max: Double
            var pressure: Double
            var humidity: Double
        }

        struct Weather: Codable {
            var id: Int
            var main: String
            var description: String
            var icon: String
        }

        struct Wind: Codable {
            var speed: Double
            var deg: Int
        }


/**
 * and some fancy structure for today's weather conditions 🥶
 */
struct WeatherTodayMoscow: Codable {
    var main: Main
    var wind: Wind
    var name: String
    var weather: [Weather]
}
