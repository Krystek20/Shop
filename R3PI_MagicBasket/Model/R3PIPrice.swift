import Foundation

struct R3PIPrice: Equatable {
    let value: Float
    let symbol: String
    
    var stringValue: String {
        return String(format: "%.2f %@", value, symbol)
    }
    
    public static func == (lhs: R3PIPrice, rhs: R3PIPrice) -> Bool {
        return lhs.symbol == rhs.symbol && lhs.value == rhs.value
    }
}
