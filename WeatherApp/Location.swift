//
//  Location.swift
//  WeatherApp
//
//  Created by Simon Zhen on 4/19/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
