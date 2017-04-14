//
//  Constants.swift
//  WeatherApp
//
//  Created by Simon Zhen on 4/12/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="

typealias DownloadComplete = () -> ()

let WEATHER_URL = "\(BASE_URL)\(LATITUDE)-3.3\(LONGITUDE)-3.3\(APP_ID)\(API_KEY)"
