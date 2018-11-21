import XCTest
@testable import R3PI_MagicBasket

class R3PIPriceTests: XCTestCase {

    func testInitPrice() {
        let sut = R3PIPrice(value: 0.12, symbol: "USD")
        
        XCTAssertEqual(sut.value, 0.12)
        XCTAssertEqual(sut.symbol, "USD")
    }
    
    func testInitPriceShouldBeTheSame() {
        let priceOne = R3PIPrice(value: 0.12, symbol: "USD")
        let priceTwo = R3PIPrice(value: 0.12, symbol: "USD")
        
        XCTAssertEqual(priceOne, priceTwo)
    }
    
    func testInitPriceShouldNotBeTheSame() {
        let priceUSD = R3PIPrice(value: 0.12, symbol: "USD")
        let priceEUR = R3PIPrice(value: 0.12, symbol: "EUR")
        
        XCTAssertNotEqual(priceUSD, priceEUR)
    }

    func testPriceShouldReturnStringValueFormat() {
        let priceUSD = R3PIPrice(value: 0.12, symbol: "USD")
        
        XCTAssertEqual(priceUSD.stringValue, "0.12 USD")
    }
    
}
