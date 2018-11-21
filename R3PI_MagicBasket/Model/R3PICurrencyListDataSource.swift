import UIKit

class R3PICurrencyListDataSource: NSObject, UITableViewDataSource {
    
    var currencyList = [R3PICurrency]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R3PIConst.R3PI_CONST_CURRENCY_CELL_VIEW_IDENTIFIER, for: indexPath)

        let currency = currencyList[indexPath.row]
        
        if let currencyCell = cell as? R3PICurrencyCellView {
            currencyCell.currencyLabel.text = currency.stringValue
        }
        
        return cell
    }
}
