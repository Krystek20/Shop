import UIKit

class R3PIAcceptButton: UIButton {

    private let cornerRadius: CGFloat = 2
    private let borderWidth: CGFloat = 1
    private let borderColor = "r3piBlueColor"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor(named: borderColor)?.cgColor
        layer.cornerRadius = cornerRadius
    }
    
}
