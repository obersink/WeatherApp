//
//  Constants.swift
//  WeatherApp
//
//  Created by Simon Zhen on 4/12/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()


var WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&units=imperial&appid=\(API_KEY)"
var FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&units=imperial&appid=\(API_KEY)"
