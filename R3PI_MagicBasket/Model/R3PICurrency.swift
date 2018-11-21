import UIKit

struct R3PICurrency: Equatable {
    let value: Float
    let symbol: String
    let sourceSymbol: String
    
    public static func == (lhs: R3PICurrency, rhs: R3PICurrency) -> Bool {
        return lhs.value == rhs.value && lhs.symbol == rhs.symbol && lhs.sourceSymbol == rhs.sourceSymbol
    }
    
    var stringValue: String {
        return String(format: "%@ - %.4f", symbol, value)
    }
}
