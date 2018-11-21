import XCTest
@testable import R3PI_MagicBasket

class R3PISummaryViewControllerTests: XCTestCase {

    var sut: R3PISummaryViewController!
    var apiClient = R3PIMockApiClient()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SummaryViewControllerStoryboardIdentifier") as? R3PISummaryViewController
        sut.apiClient = apiClient
        sut.loadViewIfNeeded()
    }
    
    func testInitSummaryViewControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testSummaryViewControllerShouldOutletsNotNil() {
        XCTAssertNotNil(sut.summaryView)
        XCTAssertNotNil(sut.summaryView.priceLabel)
    }
    
    func testSummaryViewControllerShouldSetSummaryLabelWithPrice() {
        let price = R3PIPrice(value: 1.0, symbol: "USD")
        let currency = R3PICurrency(value: 1.0, symbol: "USD", sourceSymbol: "USD")
        let exchangePrice = R3PIExchnagePrice(price: price, currency: currency)
        sut.exchnagePrice = exchangePrice
        sut.summaryView.priceLabel.text = "1.0 USD"
    }

}
