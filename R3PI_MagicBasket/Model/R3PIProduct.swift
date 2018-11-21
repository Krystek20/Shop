import Foundation

enum R3PIProdcutConverterError: Error {
    case differentCurrencySymbols
}

struct R3PIProduct: Equatable {
    let name: String
    let packageType: String
    let iconName: String
    let count: Int
    let price: R3PIPrice
    
    var productDescription: String {
        let format = "%@ per %@"
        return String(format: format, price.stringValue, packageType)
    }
    
    var increase: R3PIProduct {
        return R3PIProduct(name: name, packageType: packageType, iconName: iconName, count: count + 1, price: price)
    }
    
    var decrease: R3PIProduct {
        return R3PIProduct(name: name, packageType: packageType, iconName: iconName, count: count - 1, price: price)
    }
    
    var identifier: String {
        return String(format: "%@_%@_%@_%.2f_%@", name, packageType, iconName, price.value, price.symbol)
    }
    
    var sum: R3PIPrice {
        return R3PIPrice(value: price.value * Float(count), symbol: price.symbol)
    }
    
    public static func == (lhs: R3PIProduct, rhs: R3PIProduct) -> Bool {
        return lhs.price == rhs.price && lhs.name == rhs.name && lhs.packageType == rhs.packageType && lhs.iconName == rhs.iconName
    }
    
    static func add(_ data: [R3PIProduct]) throws -> R3PIPrice {
        let currencySymbol = data.map({ $0.price.symbol })
        let symbols = Set(currencySymbol)
        guard symbols.count == 1, let symbol = symbols.first else {
            throw R3PIProdcutConverterError.differentCurrencySymbols
        }
        
        let price = data.compactMap({ $0.sum }).reduce(0, { $0 + $1.value })
        return R3PIPrice(value: price, symbol: symbol)
    }
    
}
