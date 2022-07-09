//
//  NetworkStatus.swift
//  ExchangeAppSwiftUI
//
//  Created by Doston Rustamov on 09/07/22.
//

import Network

class NetworkConnection {
    
    static let shared = NetworkConnection()
    
    private init() {}
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnection")
    
    func check(completion: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                completion(true)
            } else {
                completion(false)
            }
        }
        
        monitor.start(queue: queue)
    }
}
