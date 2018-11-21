import UIKit

class R3PIProductListViewController: UITableViewController {
    
    let productDataSource: R3PIProductListDataSource!
    var didTapProduct: (R3PIProduct) -> () = { _ in }
    
    required init?(coder aDecoder: NSCoder) {
        productDataSource = R3PIProductListDataSource(products: R3PIConst.DEFAULT_PRODUCTS)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDataSourceSettings()
        tableView.dataSource = productDataSource
        registerCells()
    }
    
    private func setDataSourceSettings() {
        var settings = R3PIProductListDataSourceSettings()
        settings.selection = .default
        settings.isAvailableCounter = false
        productDataSource.settings = settings
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: String(describing: R3PIProductCellView.self), bundle: nil), forCellReuseIdentifier: R3PIConst.R3PI_CONST_PRODUCT_CELL_VIEW_IDENTIFIER)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let product = productDataSource.data[indexPath.row]
        didTapProduct(product)
    }
    
}
