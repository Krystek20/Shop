import UIKit

class R3PIProductListDataSource: NSObject, UITableViewDataSource {
    
    var data: [R3PIProduct]
    lazy var settings = R3PIProductListDataSourceSettings()
    
    var didIncreaseCount: (R3PIProduct) -> () = { _ in }
    var didDecreaseCount: (R3PIProduct) -> () = { _ in }
    
    init(products: [R3PIProduct]) {
        self.data = products
        
        super.init()
    }
    
    override convenience init() {
        self.init(products: [])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R3PIConst.R3PI_CONST_PRODUCT_CELL_VIEW_IDENTIFIER, for: indexPath)
        configureProduct(for: indexPath, cell: cell)
        return cell
    }
    
    private func configureProduct(for indexPath: IndexPath, cell: UITableViewCell) {
        guard let productCell = cell as? R3PIProductCellView else {
            return
        }
        
        let product = data[indexPath.row]
        productCell.nameLabel.text = product.name
        productCell.priceLabel.text = product.productDescription
        productCell.productImageView.image = UIImage(named: product.iconName)
        productCell.selectionStyle = settings.selection
        productCell.counterView.isHidden = !settings.isAvailableCounter
        productCell.counterLabel.text = String(product.count)
        productCell.plusButton.identifier = product.identifier
        productCell.minusButton.identifier = product.identifier
        productCell.plusButton.addTarget(self, action: #selector(plusButtonPressed(sender:)), for: .touchUpInside)
        productCell.minusButton.addTarget(self, action: #selector(minusButtonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc private func plusButtonPressed(sender: R3PIButton) {
        guard let index = data.firstIndex(where: { $0.identifier == sender.identifier }) else { return }
        didIncreaseCount(data[index])
    }
    
    @objc private func minusButtonPressed(sender: R3PIButton) {
        guard let index = data.firstIndex(where: { $0.identifier == sender.identifier }) else { return }
        didDecreaseCount(data[index])
    }
    
}
