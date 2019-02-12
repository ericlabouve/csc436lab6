//
//  DetailViewController.swift
//  csc436lab6
//
//  Created by Eric LaBouve on 2/11/19.
//  Copyright © 2019 Eric LaBouve. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // User Interface
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    // Metadata
    var apiStringIcon: String?
    var weatherPeriod: WeatherPeriod? {
        didSet {
            self.apiStringIcon = "http://openweathermap.org/img/w/" + weatherPeriod!.iconID + ".png"
            self.configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        // Make the API call to receive the weather data
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: apiStringIcon!)!)
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            if let data = receivedData {
                // Will run in the main thread. You can only update the UI in the main thread
                DispatchQueue.main.async {
                    self.weatherIconImageView.image = UIImage(data: data)
                    if let weatherData = self.weatherPeriod {
                        self.dateAndTimeLabel.text = weatherData.dateAndTime
                        self.conditionsLabel.text = "Conditions: " + weatherData.conditions
                        self.highTempLabel.text = "High: " + String(weatherData.highTemp) + "°F"
                        self.lowTempLabel.text = "Low: " + String(weatherData.lowTemp) + "°F"
                        self.windSpeedLabel.text = "Wind: " + String(weatherData.windSpeed) + " mph" 
                        self.windDirectionLabel.text = "Direction: " + String(weatherData.windDirection) + "°"
                        self.humidityLabel.text = "Humidity: " + String(weatherData.humidity / 100) + "%"
                    }
                }
            }
        }
        task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
