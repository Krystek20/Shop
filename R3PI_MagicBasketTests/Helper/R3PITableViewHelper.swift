import UIKit

extension UITableView {
    
    var registeredNibs: [String: UINib] {
        let dict = value(forKey: "_nibMap") as? [String: UINib]
        return dict ?? [:]
    }
    
}
