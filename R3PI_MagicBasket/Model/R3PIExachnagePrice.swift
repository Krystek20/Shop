import Foundation

struct R3PIExchnagePrice {

    let price: R3PIPrice
    let currency: R3PICurrency

    var stringValue: String {
        let format = "%.2f %@"
        return String(format: format, price.value * currency.value, currency.symbol)
    }
    
    func setCurrency(_ currency: R3PICurrency) -> R3PIExchnagePrice {
        return R3PIExchnagePrice(price: price, currency: currency)
    }
    
}
