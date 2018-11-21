import Foundation

struct R3PICurrencyResponseBuilder {
    
    let value: Double?
    let symbol: String?
    let sourceSymbol: String?
    
    init(key: String, dictionaryValue: Any, source: String) {
        value = dictionaryValue as? Double
        let extractedSymbol = key.replacingOccurrences(of: source, with: "")
        symbol = extractedSymbol.count == 0 ? source : extractedSymbol
        sourceSymbol = source
    }
    
    func build() -> R3PICurrency? {
        guard let value = value, let symbol = symbol, let sourceSymbol = sourceSymbol else { return nil }
        
        return R3PICurrency(value: Float(value), symbol: symbol, sourceSymbol: sourceSymbol)
    }
}
