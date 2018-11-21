import XCTest
@testable import R3PI_MagicBasket

class R3PIProductListViewControllerTests: XCTestCase {

    var sut: R3PIProductListViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ProductListViewControllerStoryboardIdentifier") as? R3PIProductListViewController
        sut.loadViewIfNeeded()
    }

    func testInitProductListViewControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testProductListViewControllerShouldDataSourceConnected() {
        XCTAssertNotNil(sut.productDataSource)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.productDataSource === sut.tableView.dataSource)
    }
    
    func testProductListViewControllerTableViewHasRegistredProductListCellView() {
        let cellIdentifiers = Array(sut.tableView.registeredNibs.keys)
        XCTAssertTrue(cellIdentifiers.contains("R3PIProductCellViewIdentifier"))
    }
    
    func testProductListViewControllerShouldLoadFourProductDefault() {
        XCTAssertEqual(sut.productDataSource.tableView(sut.tableView, numberOfRowsInSection: 0), 4)
    }
    
    func testProductListViewControllerTableViewShouldSeparatorNone() {
        XCTAssertEqual(sut.tableView.separatorStyle, .none)
    }
    
    func testProductViewControllerShouldSetDelegateToSelf() {
        XCTAssertTrue(sut.tableView.delegate === sut)
    }
    
    func testProductListViewControllerDidSelectCellShouldCallSelectClosureProduct() {
        let expectation = self.expectation(description: "testProductListViewControllerDidSelectCellShouldCallSelectClosureProduct")
        
        let firstProductFromDefaultList = R3PIProduct(name: "Peas", packageType: "bag", iconName: "peasIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD"))
        sut.didTapProduct = { product in
            XCTAssertEqual(product, firstProductFromDefaultList)
            expectation.fulfill()
        }
        
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testProductListViewControllerProductCellViewShouldSelectionDefault() {
        let cell = sut.productDataSource.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.selectionStyle, .default)
    }
    
    func testProductListViewControllerShouldReturnTitle() {
        XCTAssertEqual(sut.navigationItem.title, "Products")
    }
    
}
