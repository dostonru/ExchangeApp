//
//  NetworkManager.swift
//  ExchangeAppSwiftUI
//
//  Created by Doston Rustamov on 08/07/22.
//

import Foundation

class CurrencyManager {
    
    static let shared = CurrencyManager()
    
    private let apiKey = "raK9kCIHdYEpSiV9IDPqKZFJGVol8UQq"
    private var emptyCurrency = Currency(info: Currency.Info(rate: 1.0), result: 1.0)
    
    private init() {}
    
    func fetchConversion(from: String, to: String, amount: Float) -> Currency {
        let currencyCodeURL = "https://api.apilayer.com/exchangerates_data/convert?to=\(to)&from=\(from)&amount=\(amount)"
        return requestConversion(url: currencyCodeURL)
    }
    
    func requestConversion(url: String) -> Currency {
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var result: Currency = emptyCurrency
        
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: .infinity)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: request) { [unowned self] (data, response, error) in
            if let safeData = data {
                result = self.decodeJSON(conversionData: safeData)
                semaphore.signal()
            } else {
                print(String(describing: error))
                return
            }
        }
        task.resume()
        semaphore.wait()
        return result
    }
    
    func decodeJSON(conversionData : Data) -> Currency {
        let decoder = JSONDecoder()
        do {
            let conversion = try decoder.decode(Currency.self , from: conversionData)
            return conversion
        } catch {
            print(error)
            return emptyCurrency
        }
    }
}
