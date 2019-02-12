//
//  ForecastService.swift
//  csc436lab6
//
//  Created by Eric LaBouve on 2/11/19.
//  Copyright © 2019 Eric LaBouve. All rights reserved.
//

import Foundation

struct ForecastService: Codable {
    
    let list: [Period]
    
    struct Period: Codable {
        let dt: Int
        let main: MainBody
        let weather: [WeatherBody]
        let wind: WindBody
    }
    
    struct MainBody: Codable {
        let temp_min: Double
        let temp_max: Double
        let humidity: Int
    }
    
    struct WeatherBody: Codable {
        let description: String
        let icon: String
    }
    
    struct WindBody: Codable {
        let speed: Double
        let deg: Double
    }
}
