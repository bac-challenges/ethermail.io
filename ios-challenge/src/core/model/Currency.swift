//
//  Currency.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import Foundation

struct Currency: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let symbol: String
    let change: Decimal
    let price: Decimal
    
    init(name: String, symbol: String, change: Decimal, price: Decimal) {
        self.name = name
        self.symbol = symbol
        self.change = change
        self.price = price
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        symbol = try container.decode(String.self, forKey: .symbol)
        let changeString = try container.decode(String.self, forKey: .change)
        change = (Decimal(string: changeString) ?? 0)/100
        let priceString = try container.decode(String.self, forKey: .price)
        price = Decimal(string: priceString) ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case name, symbol
        case change = "changePercent24Hr"
        case price = "priceUsd"
    }
}

// Icon
extension Currency {
    var icon: String {
        "https://assets.coincap.io/assets/icons/\(symbol.lowercased())@2x.png"
    }
}

// Networking
struct Wrapper: Decodable {
    let data: [Currency]
}

extension Currency: Decodable {
    
    static var all: [Currency] {
        get async throws {
            let url = URL(string: "https://api.coincap.io/v2/assets")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
            return wrapper.data
        }
    }
}

// Mock
#if DEBUG
extension Currency {
    static var mockBitCoin: Currency {
        .init(name: "BitCoin",
              symbol: "BTC",
              change: 22,
              price: 6487931)
    }
    
    static var mockEthereum: Currency {
        .init(name: "Ethereum",
              symbol: "ETH",
              change: -11,
              price: 319608)
    }
    
    static var mockTether: Currency {
        .init(name: "Tether",
              symbol: "USDT",
              change: 2,
              price: 100)
    }
    
    static var mockBNB: Currency {
        .init(name: "BNB",
              symbol: "BNB",
              change: 120,
              price: 59988)
    }
    
    static var mockSlolana: Currency {
        .init(name: "Slolana",
              symbol: "SOL",
              change: -178,
              price: 15340)
    }
    
    static var mockItems: [Currency] {
        [.mockBitCoin,
         .mockEthereum,
         .mockTether,
         .mockBNB,
         .mockSlolana]
    }
}
#endif
