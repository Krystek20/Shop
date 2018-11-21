import UIKit

final class R3PICartViewController: UIViewController {

    @IBOutlet weak var cartView: R3PICartView!
    let dataSource = R3PIProductListDataSource()
    
    var didAddProduct: (R3PIProduct) -> () = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartView.registerCells()
        cartView.tableView.dataSource = dataSource
        didAddProduct = { [weak self] in self?.addProduct($0) }
        dataSource.didIncreaseCount = { [weak self] in self?.addProduct($0) }
        dataSource.didDecreaseCount = { [weak self] in self?.removeProduct($0) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R3PIConst.R3PI_CONST_PRODUCT_LIST_SEGUE_IDENTIFIER, let productListViewController = segue.destination as? R3PIProductListViewController {
            
            productListViewController.didTapProduct = didAddProduct
        } else if segue.identifier == R3PIConst.R3PI_CONST_SUMMARY_SEGUE_IDENTIFIER, let summaryViewController = segue.destination as? R3PISummaryViewController {
            
            do {
                let price = try R3PIProduct.add(dataSource.data)
                let currecy = R3PICurrency(value: 1.0, symbol: "USD", sourceSymbol: "USD")
                let exchangedPrice = R3PIExchnagePrice(price: price, currency: currecy)
                summaryViewController.exchnagePrice = exchangedPrice
            } catch {
                //TODO - Handle error
                print("Error to handle -> \(error.localizedDescription)")
            }
        }
    }
    
    private func addProduct(_ product: R3PIProduct) {
        if let index = dataSource.data.firstIndex(where: { $0 == product }) {
            let currentProduct = dataSource.data[index]
            dataSource.data[index] = currentProduct.increase
        } else {
            dataSource.data.append(product.increase)
        }
        cartView.tableView.reloadData()
        updateCheckoutButtonStateIfNeeded()
    }
    
    private func updateCheckoutButtonStateIfNeeded() {
        let isEnable = dataSource.data.count > 0
        cartView.checkoutButton.isEnabled = isEnable
        cartView.checkoutButton.alpha = isEnable ? 1.0 : 0.5
    }
    
    private func removeProduct(_ product: R3PIProduct) {
        guard let index = dataSource.data.firstIndex(where: { $0 == product }) else { return }
        
        let currentProduct = dataSource.data[index]
        if currentProduct.count > 1 {
            dataSource.data[index] = currentProduct.decrease
            cartView.tableView.reloadData()
        } else if currentProduct.count == 1 {
            dataSource.data.remove(at: index)
            cartView.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .bottom)
        }
        updateCheckoutButtonStateIfNeeded()
    }

}
