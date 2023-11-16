//
//  CryptoCurrency.swift
//  CryptoCrazySwiftUI
//
//  Created by Mustafa Kemal ARDA on 16.11.2023.
//

import Foundation

struct CryptoCurrency : Hashable, Decodable, Identifiable {
    
    let id = UUID()
    let currency : String
    let price : String

    private enum CodingKeys : String, CodingKey {
        case currency = "currency"
        case price = "price"
    }
    
}
