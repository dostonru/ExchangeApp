//
//  DatabaseManager.swift
//  ExchangeAppSwiftUI
//
//  Created by Doston Rustamov on 08/07/22.
//

import Foundation

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    func saveRate(with rate: Currency) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(rate)
            UserDefaults.standard.set(data, forKey: "savedRate")
        } catch {
            print("Unable to Encode Currency object \(error)")
        }
    }
    
    func getRate() -> Currency? {
        guard let data = UserDefaults.standard.data(forKey: "savedRate") else {
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let currency = try decoder.decode(Currency.self, from: data)
            return currency
        } catch {
            print("Unable to Decode Currency (\(error))")
            return nil
        }
    }
}

