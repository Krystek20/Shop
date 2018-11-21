@testable import R3PI_MagicBasket

class R3PIMockApiClient: R3PIApiClientProtocol {
    var completion: ([R3PICurrency]) -> () = { _ in }
        
    func getCurrencyList(_ completion: @escaping ([R3PICurrency]) -> ()) {
        let currencyList = [R3PICurrency(value: 0.1, symbol: "LLL", sourceSymbol: "LLL")]
            
        completion(currencyList)
        self.completion(currencyList)
            
    }
}
