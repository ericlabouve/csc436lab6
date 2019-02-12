//
//  ViewController.swift
//  csc436lab6
//
//  Created by Eric LaBouve on 2/11/19.
//  Copyright © 2019 Eric LaBouve. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // User Interface
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var summaryHigh: UILabel!
    @IBOutlet weak var summaryLow: UILabel!
    
    // Metadata
    var rows: [WeatherPeriod] = []
    var apiString5DayForecast: String = "https://api.openweathermap.org/data/2.5/forecast?zip=95030,us&units=imperial&appid=f49a4f5c9444208cb08289bd9998e0b3"
    var forecast: [ForecastService.Period] = []
    
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make the API call to receive the weather data
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: apiString5DayForecast)!)
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let txtForecastService = try decoder.decode(ForecastService.self, from: data)
                    self.forecast = txtForecastService.list
                    self.processForcast()
                    // Will run in the main thread. You can only update the UI in the main thread
                    DispatchQueue.main.async {
                        self.table.reloadData()
                        self.setPeriodSummary()
                    }
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RootToDetailSegue" {
            if let indexPath = table.indexPathForSelectedRow {
                let weatherPeriod = rows[(indexPath as NSIndexPath).row]
                (segue.destination as! DetailViewController).weatherPeriod = weatherPeriod
            }
        }
    }
    
    //MARK: - Data Processing and Reshaping
    
    // Search through all the periods to find the high and low temperatures for the forecast
    // Set the top labels with theday/time and temperature when data is found
    func setPeriodSummary() {
        var copyForecast = rows
        copyForecast.sort { $0.highTemp > $1.highTemp }
        let high = copyForecast[0]
        copyForecast.sort { $0.highTemp < $1.highTemp }
        let low = copyForecast[0]
        summaryHigh.text = "High of " + String(high.highTemp) + "°F on " + high.dateAndTime
        summaryLow.text = "Low of " + String(low.highTemp) + "°F on " + low.dateAndTime
    }
    
    // Extract data from each ForecastService.Period into a WeatherPeriod object and append to rows table
    func processForcast() {
        for period in forecast {
            rows.append(WeatherPeriod(dateAndTimeAsUnixTime: period.dt, conditions: period.weather[0].description, highTemp: period.main.temp_max, lowTemp: period.main.temp_min, windSpeed: period.wind.speed, windDirection: period.wind.deg, humidity: period.main.humidity, iconID: period.weather[0].icon))
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Set the height of each of the rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let data = rows[indexPath.row]
        cell.dateAndTimeLabel.text = data.dateAndTime
        cell.conditionsLabel.text = "Conditions: " + data.conditions
        cell.highTempLabel.text = "High: " + String(data.highTemp) + "°F"
        cell.lowTempLabel.text = "Low: " + String(data.lowTemp) + "°F"
        cell.windSpeedLabel.text = "Wind: " + String(data.windSpeed) + " mph" // Guessing units here
        cell.windDirectionLabel.text = "Direction: " + String(data.windDirection) + "°"
        cell.humidityLabel.text = "Humidity: " + String(data.humidity / 100) + "%"
        return cell
    }

}

