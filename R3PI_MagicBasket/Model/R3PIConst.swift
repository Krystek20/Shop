import Foundation

struct R3PIConst {
    
    static let R3PI_CONST_PRODUCT_CELL_VIEW_IDENTIFIER = "R3PIProductCellViewIdentifier"
    static let R3PI_CONST_CURRENCY_CELL_VIEW_IDENTIFIER = "R3PICurrencyCellViewIdentifier"
    
    static let R3PI_CONST_PRODUCT_LIST_SEGUE_IDENTIFIER = "ProductListStoryboardSegueIdentifier"
    static let R3PI_CONST_SUMMARY_SEGUE_IDENTIFIER = "SummaryStoryboardSegueIdentifier"
    static let R3PI_CONST_CURRENCY_LIST_SEGUE_IDENTIFIER = "CurrencyListStoryboardSegueIdentifier"
    
    static var DEFAULT_PRODUCTS: [R3PIProduct] {
        return [
            R3PIProduct(name: "Peas", packageType: "bag", iconName: "peasIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD")),
            R3PIProduct(name: "Eggs", packageType: "dozen", iconName: "eggsIcon", count: 0, price: R3PIPrice(value: 2.10, symbol: "USD")),
            R3PIProduct(name: "Milk", packageType: "bottle", iconName: "milkIcon", count: 0, price: R3PIPrice(value: 1.30, symbol: "USD")),
            R3PIProduct(name: "Beans", packageType: "can", iconName: "beansIcon", count: 0, price: R3PIPrice(value: 0.73, symbol: "USD"))
        ]
    }
    
}
