//
//  Weather.swift
//  WeatherApp
//
//  Created by Simon Zhen on 4/12/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit
import Alamofire

class Weather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _temp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var temp: Double {
        if _temp == nil {
            _temp = 0.0
        }
        return _temp
    }
    //@escaping DownloadComplete
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        let currentWeatherURL = URL(string: WEATHER_URL)!
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name
                    print("cityname: \(self.cityName)")
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print("weatherType: \(self.weatherType)")
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let kelvin = main["temp"] as? Double {
                        let farenheit = round((kelvin * (9/5) - 459.69))
                        self._temp = farenheit
                        print("temp: \(self.temp)")
                    }
                }
                
                DispatchQueue.main.async {
                    completed()
                }
                
            }
        }
    }
}
