import XCTest
@testable import R3PI_MagicBasket

class R3PICurrencyListViewControllerTests: XCTestCase {

    var sut: R3PICurrencyListViewController!
    let mockApiClient = R3PIMockApiClient()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CurrencyListViewControllerStoryboardIdentifier") as? R3PICurrencyListViewController
        sut.apiClient = mockApiClient
        
        sut.loadViewIfNeeded()
    }
    
    func testCurrencyListViewControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testCurrencyListViewControllerCurrencyListDataSourceIsConnected() {
        XCTAssertNotNil(sut.currencyListDataSource)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView.dataSource === sut.currencyListDataSource)
    }
    
    func testCurrencyListViewControllerTableViewBackgroundShouldBeActivityIndicator() {
        XCTAssertNotNil(sut.tableView.backgroundView)
        XCTAssertNotNil(sut.tableView.backgroundView is UIActivityIndicatorView)
    }
    
    func testCurrencyListViewControllerTableViewSeparatorStyleShouldBeNone() {
        XCTAssertTrue(sut.tableView.separatorStyle == .none)
    }
    
    func testCurrencyListViewControllerShouldFetchCurrencyList() {
        let expectation = self.expectation(description: "testCurrencyListViewControllerShouldFetchCurrencyList")
        
        sut.onActivityIndicatorView()
        sut.currencyListDataSource.currencyList.removeAll()
        XCTAssertTrue(sut.activityIndicatorView.isAnimating)
        XCTAssertFalse(sut.activityIndicatorView.isHidden)
        
        mockApiClient.completion = { currencyList in
            XCTAssertEqual(currencyList.first!, R3PICurrency(value: 0.1, symbol: "LLL", sourceSymbol: "LLL"))
            XCTAssertFalse(self.sut.activityIndicatorView.isAnimating)
            XCTAssertTrue(self.sut.activityIndicatorView.isHidden)
            XCTAssertEqual(self.sut.currencyListDataSource.currencyList.count, 1)
            expectation.fulfill()
        }
        
        sut.fetchCurrencyList()
 
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCurrencyListViewControllerCurrencyListDataSourceShouldReturnCell() {
        
        let cell = sut.currencyListDataSource.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? R3PICurrencyCellView
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.currencyLabel.text, "LLL - 0.1000")
    }
    
    
}
