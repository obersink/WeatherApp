//
//  Forecast.swift
//  WeatherApp
//
//  Created by Simon Zhen on 4/17/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    static var forecast = [Forecast]()
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["main"] as? Dictionary<String, AnyObject> {
            if let min = temp["temp_min"] as? Double {
                self._lowTemp = "\(min)"
            }
            
            if let max = temp["temp_max"] as? Double {
                self._highTemp = "\(max)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let weatherType = weather[0]["main"] as? String {
                self._weatherType = weatherType
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
    
    class func getForecasts() -> [Forecast] {
        return forecast
    }
    
    class func downloadForecast(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)!
        
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            var list = [Forecast]()
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let forecastList = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for f in forecastList {
                        let fd = Forecast(weatherDict: f)
                        list.append(fd)
                    }
                }
            }
            forecast = list
            completed()
        }
    }
}

extension Date {
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

