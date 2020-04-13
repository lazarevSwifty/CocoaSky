import UIKit

extension UIColor {
    struct MyTheme {
        static var cellBackgroundColor: UIColor {return UIColor(red: 0.1490027606, green: 0.1490303874, blue: 0.1489966214, alpha: 0.2467264525)}
        static var cellSelectionColor : UIColor {return UIColor(red: 0.1490027606, green: 0.1490303874, blue: 0.1489966214, alpha: 0.2467264525)}
        static var cellTextLabelColor:UIColor {return UIColor(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)}
        static var cellSeparatorColor: UIColor {return UIColor(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 0.5102057658)}
    }
}
struct Constants {
    
    static let cities = ["Mexico", "Moscow", "Samara", "Kaliningrad"]
    static let weatherUrl =  "https://api.openweathermap.org/data/2.5/forecast?appid=751275055a722898234d56ce0bec5b40&q="
    
    static let weekDays = ["Monday",
                           "Tuesday",
                           "Wednesday",
                           "Thursday",
                           "Friday",
                           "Saturday",
                           "Sunday"]
    
    static let fullDateFormat = "yyyy-MM-dd HH:mm:ss"
}
