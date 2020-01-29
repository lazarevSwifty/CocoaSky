//
//  NetworkingManager.swift
//  CocoaSky
//
//  Created by Владислав Лазарев on 21/11/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import Foundation


struct NetworkingManager {
    
    static func fetchOpenWeatherMap(url: String, completion: @escaping (UniversalWeather) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                let first =  weatherData.list[0]
                let main = first.main
                
                let weatherDataList = [
                    weatherData.list[7],
                    weatherData.list[15],
                    weatherData.list[23],
                    weatherData.list[31]
                ]
                
                var weatherTemperaturesOfDayList = [UniversalWeatherTemperature]()
                for item in weatherDataList {
                    let universalWeather = UniversalWeatherTemperature(
                        temp: item.main.temp,
                        desc: item.weather[0].weatherDescription.rawValue,
                        icon: item.weather[0].weatherIcon,
                        date: item.dtTxt
                    )
                    
                    weatherTemperaturesOfDayList.append(universalWeather)
                }
                let current = UniversalWeatherTemperature(
                    temp: main.temp,
                    desc: first.weather[0].weatherDescription.rawValue,
                    icon: first.weather[0].weatherIcon,
                    date: first.dtTxt
                )
                
                let weather = UniversalWeather(
                    currentTemperature: current,
                    temperaturesOnAllDay: weatherTemperaturesOfDayList
                )
                
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
}


