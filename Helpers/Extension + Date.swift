//
//  Extension + Date.swift
//  CocoaSky
//
//  Created by Владислав Лазарев on 19/12/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import Foundation

extension Date {
    static func getWeekday(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let weatherDate = dateFormatter.date(from: date) else { return "" }
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
    
    static func getDateFromString(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = dateFormatter.date(from: date)!
        
        return result
    }
}
