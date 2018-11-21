import Foundation

protocol R3PIApiClientProtocol {
    func getCurrencyList(_ completion: @escaping ([R3PICurrency]) -> ())
}

class R3PIApiClient: R3PIApiClientProtocol {
    
    enum R3PIApiClientURL: String {
        case currencyListUrl = "http://www.apilayer.net/api/live?access_key=5975515cb2b30848ca6a6fe78f84f8ab"
    }
    
    func getCurrencyList(_ completion: @escaping ([R3PICurrency]) -> ()) {
        guard let url = URL(string: R3PIApiClientURL.currencyListUrl.rawValue) else {
            completion([])
            return
        }
        
        let finished: ([R3PICurrency]) -> () = { list in
            DispatchQueue.main.async {
                completion(list)
            }
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any], let jsonDictionary = json else {
                finished([])
                return
            }
            
            finished(R3PICurrencyListResponseBuilder(dictionary: jsonDictionary).build()?.results ?? [])
        }.resume()
    }
}
