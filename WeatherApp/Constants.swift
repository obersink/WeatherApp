//
//  Constants.swift
//  WeatherApp
//
//  Created by Simon Zhen on 4/12/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let WEATHER = "weather?"
let FORECAST = "forecast?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let UNITS = "&units=imperial"

typealias DownloadComplete = () -> ()

let WEATHER_URL = "\(BASE_URL)\(WEATHER)\(LATITUDE)35\(LONGITUDE)139\(UNITS)\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(BASE_URL)\(FORECAST)\(LATITUDE)35\(LONGITUDE)139\(UNITS)\(APP_ID)\(API_KEY)"

