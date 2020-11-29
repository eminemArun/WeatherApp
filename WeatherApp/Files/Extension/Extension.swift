import Foundation
import UIKit

// Helper for get tommorow date in format
extension NSObject{
    func tommorow() -> String{
        let tomorrow = Date().addingTimeInterval(60 * 60 * 24)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let stringDate = dateFormatter.string(from: tomorrow)
        return stringDate
    }
}

// For loading image from server to UIImageView
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

// For loading indicator
extension UIView{
    func activityStartAnimating(activityColor: UIColor = UIColor.white,
                                backgroundColor: UIColor = Color.activityBackground) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 10
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(10){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}


//App color
struct Color {
  static let activityBackground = UIColor.black.withAlphaComponent(0.5)

}
