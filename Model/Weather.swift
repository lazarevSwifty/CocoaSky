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
        return getTemperature(UserSettings.getTemperature())
    }
    
    func getTemperature(_ type: TemperatureType = .celsius) -> String {
        switch type {
        case .celsius:
            return  String(Int(temp - 273))
        case .fahrenheit:
            return  String(Int(temp * 9 / 5 - 459))
        }
    }
    
    func getCurrentAttributteTemperature() -> String {
        return getAttributteTemperature(UserSettings.getTemperature())
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
        dateFormatter.dateFormat = Constants.fullDateFormat
        guard let weatherDate = dateFormatter.date(from: self.date) else { return "" }
        let calendar = Calendar.current.component(.weekday, from: weatherDate)
        return Constants.weekDays[calendar - 1]
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.fullDateFormat
        return dateFormatter.date(from: date)
    }
}
