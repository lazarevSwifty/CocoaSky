//
//  ForecastCell.swift
//  CocoaSky
//
//  Created by Владислав Лазарев on 03/12/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var imageOfWeather: UIImageView!
    @IBOutlet var tempretureLabel: UILabel!
    
    func configure(temp: UniversalWeatherTemperature) {
        dayLabel.text = temp.getWeekday()
        imageOfWeather.setWeatherIcon(icon: temp.icon)
        tempretureLabel.text = temp.getCurrentTemperature()
    }
}
