//
//  Currency.swift
//  ExchangeAppSwiftUI
//
//  Created by Doston Rustamov on 08/07/22.
//

import Foundation

struct Currency: Codable {
    var info : Info
    var result : CGFloat
    
    struct Info : Codable {
        var rate : CGFloat
    }
}

