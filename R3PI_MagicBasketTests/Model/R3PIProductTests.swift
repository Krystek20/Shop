import XCTest
@testable import R3PI_MagicBasket

class R3PIProductTests: XCTestCase {
    
    var sut: R3PIProduct!
    
    override func setUp() {
        super.setUp()
        
        sut = R3PIProduct(name: "exampleName", packageType: "examplePackageType", iconName: "exampleIconName", count: 0, price: R3PIPrice(value: 0.12, symbol: "LLL"))
    }

    
    func testInitProduct() {
        XCTAssertEqual(sut.name, "exampleName")
        XCTAssertEqual(sut.packageType, "examplePackageType")
        XCTAssertEqual(sut.price, R3PIPrice(value: 0.12, symbol: "LLL"))
        XCTAssertEqual(sut.iconName, "exampleIconName")
    }
    
    func testProductDescription() {
        XCTAssertEqual(sut.productDescription, "0.12 LLL per examplePackageType")
    }

    func testProductShouldReturnUniqueIdentifier() {
        XCTAssertEqual(sut.identifier, "exampleName_examplePackageType_exampleIconName_0.12_LLL")
    }
    
    func testSumProductsShouldThrowErrorWhenCurrencySymbolsAreDifferent() {
        let firstProduct = R3PIProduct(name: "exampleName", packageType: "examplePackageType", iconName: "exampleIconName", count: 1, price: R3PIPrice(value: 0.12, symbol: "USD"))
        
        let secondProduct = R3PIProduct(name: "exampleName", packageType: "examplePackageType", iconName: "exampleIconName", count: 1, price: R3PIPrice(value: 0.12, symbol: "EUR"))
        
        XCTAssertThrowsError(try R3PIProduct.add([firstProduct, secondProduct]), "") { error in
            XCTAssertEqual(error as! R3PIProdcutConverterError, R3PIProdcutConverterError.differentCurrencySymbols)
        }
    }
    
    func testSumProductsShouldReturnPrice() {
        let firstProduct = R3PIProduct(name: "exampleName", packageType: "examplePackageType", iconName: "exampleIconName", count: 1, price: R3PIPrice(value: 0.12, symbol: "LLL"))
        
        let secondProduct = R3PIProduct(name: "exampleName", packageType: "examplePackageType", iconName: "exampleIconName", count: 1, price: R3PIPrice(value: 0.12, symbol: "LLL"))
        
        
        let price = try! R3PIProduct.add([firstProduct, secondProduct])
        XCTAssertEqual(price, R3PIPrice(value: 0.24, symbol: "LLL"))
    }
    
}
