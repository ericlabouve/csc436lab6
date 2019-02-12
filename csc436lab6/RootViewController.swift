//
//  ViewController.swift
//  csc436lab6
//
//  Created by Eric LaBouve on 2/11/19.
//  Copyright © 2019 Eric LaBouve. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var rows: [WeatherPeriod] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let data = rows[indexPath.row]
        cell.dateAndTimeLabel.text = data.dateAndTime
        cell.conditionsLabel.text = data.conditions
        cell.highTempLabel.text = "High: " + String(data.highTemp) + "°"
        cell.lowTempLabel.text = "Low: " + String(data.lowTemp) + "°"
        cell.windSpeedLabel.text = "Wind: " + String(data.windSpeed) + "mph" // Guessing units here
        cell.windDirectionLabel.text = "Direction: " + String(data.windDirection) + "°"
        cell.humidityLabel.text = "Humidity: " + String(data.humidity / 100) + "%"
        return cell
    }

}

