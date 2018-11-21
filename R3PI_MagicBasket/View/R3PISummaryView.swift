import UIKit

class R3PISummaryView: UIView {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    func onActivityIndicatorView() {
        UIView.animate(withDuration: 0.5) {
            self.activityIndicator.alpha = 1.0
            self.priceLabel.alpha = 0.0
        }
    }
    
    func offActivityIndicatorViewIfOn() {
        UIView.animate(withDuration: 0.5) {
            self.activityIndicator.alpha = 0.0
            self.priceLabel.alpha = 1.0
        }
    }
    
}
