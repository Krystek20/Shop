import UIKit

class R3PICartView: UIView {
    
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    

    func registerCells() {
        tableView.register(UINib(nibName: String(describing: R3PIProductCellView.self), bundle: nil), forCellReuseIdentifier: R3PIConst.R3PI_CONST_PRODUCT_CELL_VIEW_IDENTIFIER)
    }
    
}
