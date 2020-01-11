//
//  NetworkingManager.swift
//  CocoaSky
//
//  Created by Владислав Лазарев on 21/11/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import Foundation


struct NetworkingManager {
    
    static func fetchData(url: String, completion: @escaping (WeatherData) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }

}
