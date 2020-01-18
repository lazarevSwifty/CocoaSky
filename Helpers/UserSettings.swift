//
//  UserDefaultsManager.swift
//  CocoaSky
//
//  Created by Владислав Лазарев on 12/01/2020.
//  Copyright © 2020 Владислав Лазарев. All rights reserved.
//

import Foundation

enum TemperatureType: Int {
    case celsius
    case fahrenheit
}

struct UserSettings {
    private static let userDefault = UserDefaults.standard
    
    static func setTemperature(_ type: TemperatureType) {
         userDefault.set(type.rawValue, forKey: "TemperatureType")
    }
    
    static func getTemperature() -> TemperatureType {
        let tempType = userDefault.integer(forKey: "TemperatureType")
        return TemperatureType(rawValue: tempType) ?? TemperatureType.celsius
    }
    
    static func setSelectedIndex(_ index: Int) {
        userDefault.set(index, forKey: "SelectedIndex")
    }
    
    static func getSelectedIndex() -> Int {
        return userDefault.integer(forKey: "SelectedIndex")
    }
    
    static func saveLastWeather(_ weather: UniversalWeather) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(weather) {
            userDefault.set(encoded, forKey: "LastWeather")
        }
    }
    
    static func getLastWeather() -> UniversalWeather? {
        let data = userDefault.object(forKey: "LastWeather") as? Data
        guard let savedWeather = data else {
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let loadedWeather = try decoder.decode(UniversalWeather.self, from: savedWeather)
           return loadedWeather
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
