//
//  WeatherPeriod.swift
//  csc436lab6
//
//  Created by Eric LaBouve on 2/11/19.
//  Copyright © 2019 Eric LaBouve. All rights reserved.
//

import Foundation

class WeatherPeriod: Codable {
    
    var dateAndTime: String
    var conditions: String
    var highTemp: Double
    var lowTemp: Double
    var windSpeed: Double
    var windDirection: Double
    var humidity: Int
    var iconID: String
    
    init(dateAndTimeAsUnixTime: Int, conditions: String, highTemp: Double, lowTemp: Double, windSpeed: Double, windDirection: Double, humidity: Int, iconID: String) {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .medium
        dateAndTime = df.string(from: Date(timeIntervalSince1970: Double(dateAndTimeAsUnixTime)))
        self.conditions = conditions
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.humidity = humidity
        self.iconID = iconID
    }
}
