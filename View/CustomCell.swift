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
