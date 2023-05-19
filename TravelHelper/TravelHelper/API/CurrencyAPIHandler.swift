//
//  CurrencyAPIHandler.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/9/23.
//

import Foundation

struct CurrencyResponseData : Decodable {
    let date: String
    let result: Double
}


class CurrencyAPIHandler {
    
    // let baseURL = "https://api.apilayer.com/exchangerates_data/latest?symbols=symbols&base=EUR"
    // let templateURL = "https://api.apilayer.com/exchangerates_data/convert?to=GBP&from=EUR&amount=100&apikey=1mKnYXSV2Ityo6ayBxAEIrWgyJ2WYDIt"
    let apiKey = "1mKnYXSV2Ityo6ayBxAEIrWgyJ2WYDIt"
    
    static let shared = CurrencyAPIHandler()
        
    func fetchCurrencyInfo(from: String, to: String, amount: Double, callback: @escaping (_ data: CurrencyResponseData) -> Void) {
        guard let url = URL(string: "https://api.apilayer.com/exchangerates_data/convert?to=\(to)&from=\(from)&apikey=\(apiKey)&amount=\(amount)") else {
            // Todo: Handle error
            return
        }
        // Singleton: There is one istance assigned to the `shared` property that will live on for the entire life of the running of the app.
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (maybeDate: Data?, maybeResponse: URLResponse?, maybeError: Error?) in
            // We should handle errors in the urlresponse and in the error object as well.
            guard let data = maybeDate else {
                // We should handle this...
                return
            }
            print(data)
            let decoder = JSONDecoder()
            do {
                let currencyResponse = try decoder.decode(CurrencyResponseData.self, from: data)
                callback(currencyResponse)
            } catch {
                print(error)
            }
        })
        task.resume()
    }
}
