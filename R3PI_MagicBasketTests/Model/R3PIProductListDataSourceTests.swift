import XCTest
@testable import R3PI_MagicBasket

class R3PIProductListDataSourceTests: XCTestCase {

    func testInitProductListDataSourceShouldReturnZeroCount() {
        let sut = R3PIProductListDataSource()
        
        XCTAssertEqual(sut.data.count, 0)
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: 0), 0)
    }
    
    func testInitProductListDataSourceShouldReturnTwoCount() {
        let sut = R3PIProductListDataSource(products: products)
        
        XCTAssertEqual(sut.data.count, 2)
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: 0), 2)
    }
    
    func testProductListDataSourceShouldReturnSetCellForRowAtZero() {
        let sut = R3PIProductListDataSource(products: products)
        
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? R3PIProductCellView
        
        XCTAssertEqual(cell?.nameLabel.text, "Eggs")
        XCTAssertEqual(cell?.priceLabel.text, "0.95 USD per leaflet")
        XCTAssertNotNil(cell?.productImageView.image)
    }
    
    func testProductListDataSourceProductCellViewShouldSelectionDefault() {
        let sut = R3PIProductListDataSource(products: products)

        var cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? R3PIProductCellView
        
        XCTAssertEqual(cell?.selectionStyle, UITableViewCell.SelectionStyle.none)
        
        var settings = R3PIProductListDataSourceSettings()
        settings.selection = .default
        sut.settings = settings
        
        cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? R3PIProductCellView
        
        XCTAssertEqual(cell?.selectionStyle, .default)
    }
    
    func testProductListDataSourceProductCellViewShouldNotShowCountNumber() {
        let sut = R3PIProductListDataSource(products: products)
        
        var cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        
        XCTAssertFalse(cell.counterView.isHidden)
        
        var settings = R3PIProductListDataSourceSettings()
        settings.isAvailableCounter = false
        sut.settings = settings
        
        cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        
        XCTAssertTrue(cell.counterView.isHidden)
    }
    
    func testProductListDataSourceProductCellViewSetIdentifierForPlusAndMinusButton() {
        let sut = R3PIProductListDataSource(products: products)
        
        var cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        
        let firstProductIdentifier = products[0].identifier
        XCTAssertEqual(cell.plusButton.identifier, firstProductIdentifier)
        XCTAssertEqual(cell.minusButton.identifier, firstProductIdentifier)
        
        cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as! R3PIProductCellView
        
        let secondProductIdentifier = products[1].identifier
        XCTAssertEqual(cell.plusButton.identifier, secondProductIdentifier)
        XCTAssertEqual(cell.minusButton.identifier, secondProductIdentifier)
    }
    
    func testProductListDataSourceProductCellViewShouldCallToIncrementClosureAtIndexPathRowOne() {
        let expectation = self.expectation(description: "testProductListDataSourceProductCellViewShouldCallToIncrementClosure")
        
        let sut = R3PIProductListDataSource(products: products)
        sut.didIncreaseCount = { product in
            XCTAssertEqual(product, R3PIProduct(name: "Basil", packageType: "leaflet", iconName: "basilIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "EUR")))
            expectation.fulfill()
        }
        
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as! R3PIProductCellView
        cell.plusButton.sendActions(for: .touchUpInside)
    
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}

extension R3PIProductListDataSourceTests {
    var tableView: UITableView {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "R3PIProductCellView", bundle: Bundle(for: R3PIProductCellView.self)), forCellReuseIdentifier: "R3PIProductCellViewIdentifier")
        return tableView
    }
    
    var products: [R3PIProduct] {
        return [
            R3PIProduct(name: "Eggs", packageType: "leaflet", iconName: "eggsIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD")),
            R3PIProduct(name: "Basil", packageType: "leaflet", iconName: "basilIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "EUR"))
        ]
    }
}
