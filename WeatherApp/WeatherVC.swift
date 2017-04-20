//
//  ViewController.swift
//  WeatherApp
//
//  Created by Simon Zhen on 4/8/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: Weather!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentWeather = Weather()
        
        currentWeather.downloadWeatherDetails {
            self.updateUI()
        }
        
        Forecast.downloadForecast {
            self.forecasts = Forecast.forecast
//            for i in self.forecasts {
//                
//            }
            self.tableView.reloadData()
            print("download")
        }
        
    }
    
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
            print("configured cell")
            return cell
        }
        else {
            return WeatherCell()
        }
    }
    
}

