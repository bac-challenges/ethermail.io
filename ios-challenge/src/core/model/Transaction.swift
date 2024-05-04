//
//  Transaction.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import Foundation

struct Transaction: Hashable {
    let date: Date
    let amount: Decimal
    let currency: Currency
}

// Networking
extension Transaction: Decodable {
    static var all: [Transaction] {
        get async throws {
            Transaction.mockItems
        }
    }
}

// Mock
#if DEBUG
extension Transaction {
    static var mockItem: Transaction {
        .init(
            date: Date(),
            amount: 100,
            currency: Currency.mockBitCoin)
    }
    
    static var mockItems: [Transaction] {
        [
            .init(
                date: Date().addingTimeInterval(-6000),
                amount: 7000000,
                currency: Currency.mockBitCoin),
            
            .init(
                date: Date().addingTimeInterval(-5500),
                amount: 300000,
                currency: Currency.mockBitCoin),
            
            .init(
                date: Date().addingTimeInterval(-5000),
                amount: 15000000,
                currency: Currency.mockBitCoin),
            
            .init(
                date: Date().addingTimeInterval(-4000),
                amount: 30000,
                currency: Currency.mockEthereum),
            
            .init(
                date: Date().addingTimeInterval(-3000),
                amount: 1400,
                currency: Currency.mockTether),
            
            .init(
                date: Date().addingTimeInterval(-2000),
                amount: 5000,
                currency: Currency.mockBNB),
            
            .init(
                date: Date().addingTimeInterval(-1000),
                amount: 8550,
                currency: Currency.mockSlolana)
        ]
    }
}
#endif
