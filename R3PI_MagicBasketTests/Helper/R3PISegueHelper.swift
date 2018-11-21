import UIKit

extension UIViewController {
    
    var segueIdentifiers: [String] {   
        let segues = value(forKey: "storyboardSegueTemplates") as? [NSObject]
        let filtered = segues?.compactMap({ $0.value(forKey: "identifier") as? String })
        
        return filtered ?? []
    }
    
}
