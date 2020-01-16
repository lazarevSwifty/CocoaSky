//
//  Extension + UIImageView.swift
//  CocoaSky
//
//  Created by Владислав Лазарев on 08/12/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func dowlandImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        _ = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
            }.resume
    }
    
    func setWeatherIcon(icon: String) {
        self.image = UIImage(named: icon)
    }
}
