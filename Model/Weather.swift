//
//  Weather.swift
//  
//
//  Created by Владислав Лазарев on 15.01.2020.
//

import Foundation

struct UniversalWeather: Codable {
    var currentTemperature: UniversalWeatherTemperature
    var temperaturesOnAllDay: [UniversalWeatherTemperature]
}

struct UniversalWeatherTemperature: Codable {
    var temp: Double
    var desc: String
    var icon: String
    var date: String
    
}

extension UniversalWeatherTemperature {
    
    func getCurrentTemperature() -> String {
        return self.getTemperature(UserSettings.getTemperature())
    }
    
    func getTemperature(_ type: TemperatureType = .celsius) -> String {
        switch type {
        case .celsius:
            return  String(Int(self.temp - 273))
        case .fahrenheit:
            return  String(Int(self.temp * 9 / 5 - 459))
        }
    }
    
    func getCurrentAttributteTemperature() -> String {
        return self.getAttributteTemperature(UserSettings.getTemperature())
    }
    
    func getAttributteTemperature(_ type: TemperatureType = .celsius) -> String {
        switch type {
        case .celsius:
            return "C"
        case .fahrenheit:
            return "F"
        }
    }
    
    func getWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let weatherDate = dateFormatter.date(from: self.date) else { return "" }
        let calendat = Calendar.current.component(.weekday, from: weatherDate)
        switch calendat {
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        case 7,0:
            return "Sunday"
        default:
            return "error"
        }
        
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: date)
    }
}
