import XCTest
@testable import R3PI_MagicBasket

class R3PIExchangePriceTests: XCTestCase {

    func testinitExchangePrice() {
        let price = R3PIPrice(value: 1, symbol: "USD")
        let currency = R3PICurrency(value: 0.876765, symbol: "EUR", sourceSymbol: "USD")
        
        let exchangedPrice = R3PIExchnagePrice(price: price, currency: currency)
        XCTAssertEqual(exchangedPrice.stringValue, "0.88 EUR")
    }

}
