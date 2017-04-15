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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentWeather = Weather()
        currentWeather.downloadWeatherDetails {
            self.updateUI()
        }
    }
    
    func updateUI() {
        dateLabel.text = currentWeather.date
        temperatureLabel.text = "\(currentWeather.temp)"
        cityLabel.text = currentWeather.cityName
        weatherImage.image = UIImage(named: currentWeather.weatherType)
        weatherTypeLabel.text = currentWeather.weatherType
        print(currentWeather.temp)
        print(currentWeather.weatherType)
    }

}

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        return cell
    }
    
}

