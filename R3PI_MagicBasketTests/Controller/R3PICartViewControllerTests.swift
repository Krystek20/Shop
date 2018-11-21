import XCTest
@testable import R3PI_MagicBasket

class R3PICartViewControllerTests: XCTestCase {

    var sut: R3PICartViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CartViewControllerStoryboardIdentifier") as? R3PICartViewController
        sut.loadViewIfNeeded()
    }

    func testInitCartViewControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testCartViewControllerCartViewOutletShouleBeNotNil() {
        XCTAssertNotNil(sut.cartView)
    }
    
    func testCartViewControllerCartViewOutletsNotNil() {
        XCTAssertNotNil(sut.cartView.tableView)
        XCTAssertNotNil(sut.cartView.checkoutButton)
    }

    func testCartViewControllerTableViewShouldBeSet() {
        XCTAssertEqual(sut.cartView.tableView.backgroundColor, UIColor.clear)
        XCTAssertEqual(sut.cartView.tableView.separatorStyle, .none)
    }
    
    func testCartViewControllerCheckoutButtonShouldBeSet() {
        let checkoutButton = sut.cartView.checkoutButton
        
        XCTAssertEqual(checkoutButton?.layer.cornerRadius, 2)
        XCTAssertEqual(checkoutButton?.titleLabel?.text, "Checkout")
    }
    
    func testCartViewContrllerShouldConnectDataSourceToTableView() {
        XCTAssertNotNil(sut.dataSource)
        XCTAssertNotNil(sut.cartView.tableView.dataSource)
    }
    
    func testCartViewControllerTableViewShouldSeparatorNone() {
        XCTAssertEqual(sut.cartView.tableView.separatorStyle, .none)
    }
    
    func testCartViewControllerTableViewHasRegistredProductListCellView() {
        let cellIdentifiers = Array(sut.cartView.tableView.registeredNibs.keys)
        XCTAssertTrue(cellIdentifiers.contains("R3PIProductCellViewIdentifier"))
    }
    
    func testCartControllerShouldBeEmptyDefault() {
        XCTAssertEqual(sut.dataSource.tableView(sut.cartView.tableView, numberOfRowsInSection: 0), 0)
    }
    
    func testCartControllerNavigationItemTitleNotNil() {
        XCTAssertNotNil(sut.navigationItem.title)
    }

    func testCartViewControllerAddButtonShouldHasTarget() {
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem?.target)
    }
    
    func testCartViewControllerShouldContainSegueToProductList() {
        let segues = sut.segueIdentifiers
        XCTAssertTrue(segues.contains("ProductListStoryboardSegueIdentifier"))
    }
    
    func testCartViewControllerProductCellViewShouldSelectionNone() {
        let product = R3PIProduct(name: "Peas", packageType: "bag", iconName: "peasIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD"))
        sut.dataSource.data.append(product)
        
        let cell = sut.dataSource.tableView(sut.cartView.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.selectionStyle, .none)
    }
    
    func testCartViewControllerShouldPassAddProductToProductViewController() {
        let expectation = self.expectation(description: "testCartViewControllerShouldPassAddProductToProductViewController")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let productListViewController = storyboard.instantiateViewController(withIdentifier: "ProductListViewControllerStoryboardIdentifier") as! R3PIProductListViewController
        
        let segue = UIStoryboardSegue(identifier: "ProductListStoryboardSegueIdentifier", source: sut, destination: productListViewController)
        
        sut.didAddProduct = { _ in
            expectation.fulfill()
        }
        
        sut.prepare(for: segue, sender: nil)
        productListViewController.loadViewIfNeeded()
        productListViewController.tableView(productListViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCartViewControllerShouldAddNewProductWhenNotExist() {
        let product = R3PIProduct(name: "Peas", packageType: "bag", iconName: "peasIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD"))
        
        sut.didAddProduct(product)
        
        let cell = sut.dataSource.tableView(sut.cartView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        XCTAssertEqual(cell.counterLabel.text, "1")
        XCTAssertEqual(sut.dataSource.data.count, 1)
    }
    
    func testCartViewControllerTwiceTheSameProductShouldReturnCountTwo() {
        let product = R3PIProduct(name: "Peas", packageType: "bag", iconName: "peasIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD"))
        
        sut.didAddProduct(product)
        
        var cell = sut.dataSource.tableView(sut.cartView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        XCTAssertEqual(cell.counterLabel.text, "1")
        XCTAssertEqual(sut.dataSource.data.count, 1)
        
        sut.didAddProduct(product)
        
        cell = sut.dataSource.tableView(sut.cartView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        XCTAssertEqual(cell.counterLabel.text, "2")
        XCTAssertEqual(sut.dataSource.data.count, 1)
    }
    
    func testCartViewControllerAddNewProductAndTwicePlusButtonShouldReturnThreeProductCount() {
        let product = R3PIProduct(name: "Peas", packageType: "bag", iconName: "peasIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD"))
        
        sut.didAddProduct(product)
        
        var cell = sut.dataSource.tableView(sut.cartView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        XCTAssertEqual(cell.counterLabel.text, "1")
        XCTAssertEqual(sut.dataSource.data.count, 1)
        
        cell.plusButton.sendActions(for: .touchUpInside)
        cell.plusButton.sendActions(for: .touchUpInside)
        
        cell = sut.dataSource.tableView(sut.cartView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        XCTAssertEqual(cell.counterLabel.text, "3")
        XCTAssertEqual(sut.dataSource.data.count, 1)
    }
    
    func testCartViewControllerDecrementTwiceShouldReturnOneProductCount() {
        let product = R3PIProduct(name: "Peas", packageType: "bag", iconName: "peasIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD"))
        
        sut.didAddProduct(product)
        sut.didAddProduct(product)
        sut.didAddProduct(product)
        
        var cell = sut.dataSource.tableView(sut.cartView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        XCTAssertEqual(cell.counterLabel.text, "3")
        XCTAssertEqual(sut.dataSource.data.count, 1)
        
        cell.minusButton.sendActions(for: .touchUpInside)
        cell.minusButton.sendActions(for: .touchUpInside)
        
        cell = sut.dataSource.tableView(sut.cartView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        XCTAssertEqual(cell.counterLabel.text, "1")
        XCTAssertEqual(sut.dataSource.data.count, 1)
    }
    
    func testCartViewControllerDecrementShouldRemoveWhenProductCountZero() {
        let product = R3PIProduct(name: "Peas", packageType: "bag", iconName: "peasIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD"))
        
        sut.didAddProduct(product)
        
        let cell = sut.dataSource.tableView(sut.cartView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        XCTAssertEqual(cell.counterLabel.text, "1")
        XCTAssertEqual(sut.dataSource.data.count, 1)
        
        cell.minusButton.sendActions(for: .touchUpInside)

        XCTAssertEqual(sut.dataSource.data.count, 0)
    }
    
    func testCartViewControllerCheckoutButtonShouldBeDisableWhenEmptyCart() {
        XCTAssertFalse(sut.cartView.checkoutButton.isEnabled)
        XCTAssertTrue(sut.cartView.checkoutButton.alpha == 0.5)
        
        let product = R3PIProduct(name: "Peas", packageType: "bag", iconName: "peasIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD"))
        
        sut.didAddProduct(product)
        
        XCTAssertTrue(sut.cartView.checkoutButton.isEnabled)
        XCTAssertTrue(sut.cartView.checkoutButton.alpha == 1.0)
    }
    
    func testCartViewControllerCheckoutButtonShouldBeDisableWhenRemovedLastProduct() {
        let product = R3PIProduct(name: "Peas", packageType: "bag", iconName: "peasIcon", count: 0, price: R3PIPrice(value: 0.95, symbol: "USD"))
        
        sut.didAddProduct(product)
        
        XCTAssertTrue(sut.cartView.checkoutButton.isEnabled)
        XCTAssertTrue(sut.cartView.checkoutButton.alpha == 1.0)
        
        let cell = sut.dataSource.tableView(sut.cartView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! R3PIProductCellView
        
        cell.minusButton.sendActions(for: .touchUpInside)
        
        XCTAssertFalse(sut.cartView.checkoutButton.isEnabled)
        XCTAssertTrue(sut.cartView.checkoutButton.alpha == 0.5)
    }
    
    func testCartViewControllerCheckoutButtonShouldHasTarget() {
        XCTAssertNotNil(sut.cartView.checkoutButton.target)
    }
    
    func testCartViewControllerShouldContainSegueToSummary() {
        let segues = sut.segueIdentifiers
        XCTAssertTrue(segues.contains("SummaryStoryboardSegueIdentifier"))
    }
    
}
