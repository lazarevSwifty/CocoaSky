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
    func setWeatherIcon(icon: String) {
        self.image = UIImage(named: icon)
    }
}
