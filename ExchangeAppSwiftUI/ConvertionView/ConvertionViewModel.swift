//  ConvertionViewModel.swift
//  ExchangeAppSwiftUI
//  Created by Doston Rustamov on 08/07/22.

import Foundation

protocol Convertion {
    func convertCurrency(from inValue: String, to outValue: String, amount: Float)
}

class ConvertionViewModel: ObservableObject, Convertion {
    
    @Published var rate: CGFloat = 0
    @Published var amount: String = "0"
    
    func convertCurrency(from inValue: String, to outValue: String, amount: Float) {
        NetworkConnection.shared.check { [unowned self] status in
            switch status {
            case true:
                let currency = CurrencyManager.shared.fetchConversion(from: inValue, to: outValue, amount: amount)
                self.updateCurrency(with: currency)
                
                DatabaseManager.shared.saveRate(with: currency)
            case false:
                self.getSavedData()
                self.amount = "\(CGFloat(amount) * self.rate)"
            }
        }
        
    }
    
    
    func updateCurrency(with model: Currency) {
        DispatchQueue.main.async { [weak self] in
            self?.rate = model.info.rate
            self?.amount = "\(model.result)"
        }
    }
    
    func getSavedData() {
        guard let currency = DatabaseManager.shared.getRate() else {
            return
        }
        self.rate = currency.info.rate
    }
}
