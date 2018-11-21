import XCTest
@testable import R3PI_MagicBasket

class R3PICurrencyListApiTests: XCTestCase {

    func testInitCurrencyList() {
        let dictionary: [String: Any] = ["source" : "USD", "quotes": ["USDANG" : 484.289942, "USDBRL" : 71.130274]]
        
        let currencyList = R3PICurrencyListResponseBuilder(dictionary: dictionary).build()
        XCTAssertNotNil(currencyList)
    }
    
    func testCurrencyListBadKeyShouldReturnZero() {
        let dictionary: [String: Any] = ["source" : "USD", "quotesas": ["USDANG" : 484.289942, "USDBRL" : 71.130274]]
        
        let currencyList = R3PICurrencyListResponseBuilder(dictionary: dictionary).build()
        XCTAssertEqual(currencyList?.results.count, 0)
    }
    
    func testInitOneCurrency() {
        let currency = R3PICurrencyResponseBuilder(key: "USDANG", dictionaryValue: 484.289942, source: "USD").build()
        XCTAssertNotNil(currency)
        XCTAssertEqual(currency?.sourceSymbol, "USD")
        XCTAssertEqual(currency?.symbol, "ANG")
        XCTAssertEqual(currency?.value, 484.289942)
    }

    
}
