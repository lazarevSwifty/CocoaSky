import Foundation
import UIKit

extension UIImageView {
    func setWeatherIcon(icon: String) {
        self.image = UIImage(named: icon)
    }
}
