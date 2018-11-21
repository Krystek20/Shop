import Foundation

struct R3PICurrencyListResponseBuilder {
    
    let results: [R3PICurrencyResponseBuilder]?
    
    init(dictionary: [String: Any]) {
        let source = dictionary["source"] as? String ?? ""
        let currencyDictionary = dictionary["quotes"] as? [String : Any] ?? [:]
        
        results = currencyDictionary.compactMap({ R3PICurrencyResponseBuilder(key: $0.key, dictionaryValue: $0.value, source: source) })
    }
    
    func build() -> R3PICurrencyListResponseModel? {
        guard let results = results else {
            return nil
        }
        return R3PICurrencyListResponseModel(results: results.compactMap { $0.build() })
    }
    
}
