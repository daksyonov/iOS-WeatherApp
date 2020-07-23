//
//  WeatherGetter.swift
//  WeatherForecast
//
//  Created by Dmitry Aksyonov on 04.03.2020.
//  Copyright © 2020 Dmitry Aksyonov. All rights reserved.
//

import Foundation

class GetWeather {
    
    /**
      * The class for obtainig raw JSON data (forecast) and decoding it to system-readable format
      * Request is handled via URLSession singleton
      * Simple error-handling via do-catch clause implemented
      * JSON decoded via .decode respectively
    */
    
    func getMowForecast(completion: @escaping ((WeatherForecast?, Bool)) -> Void) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=b3d57a41f87619daf456bfefa990fce4&units=metric")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(WeatherForecast.self, from: data)
                    completion((json, true))
                } catch {
                    print(error)
                    completion((nil, false))
                }
            } else {
                print(error)
            }
        }
        task.resume()
    }
    
    
    /**
     * Same task but for today's weather
     * the idea is that user first glances on the main screen and if he or she wants to get the breakdown - he'll traverl to the forecast data
     */
    
    func getCurrenMowWeather(completion: @escaping ((WeatherTodayMoscow?, Bool)) -> Void) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=524901&APPID=b3d57a41f87619daf456bfefa990fce4&units=metric")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(WeatherTodayMoscow.self, from: data)
                    completion((json, true))
                } catch {
                    print(error)
                    completion((nil, true))
                }
                
            } else {
                print(error)
                completion((nil, false))
            }
        }
        task.resume()
    }
}
