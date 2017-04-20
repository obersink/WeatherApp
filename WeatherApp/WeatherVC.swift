//
//  ViewController.swift
//  WeatherApp
//
//  Created by Simon Zhen on 4/8/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: Weather!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        currentWeather = Weather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        
        currentWeather.downloadWeatherDetails {
            self.updateUI()
            
        }
    }
    
    //sets top view
    func updateUI() {
        dateLabel.text = currentWeather.date
        temperatureLabel.text = "\(currentWeather.temp)°"
        cityLabel.text = currentWeather.cityName
        weatherImage.image = UIImage(named: currentWeather.weatherType)
        weatherTypeLabel.text = currentWeather.weatherType
    }

}

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(forecasts.count)")
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }
        else {
            return WeatherCell()
        }
    }
}

extension WeatherVC: CLLocationManagerDelegate {
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print("coordinates: \(currentLocation.coordinate)")
            
            currentWeather.downloadWeatherDetails {
                self.updateUI()
            }
            
            Forecast.downloadForecast {
                self.forecasts = Forecast.forecast
                self.tableView.reloadData()
            }
        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
}
