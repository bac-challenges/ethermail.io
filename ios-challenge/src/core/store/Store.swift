//
//  Store.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import Foundation

protocol StoreProvider {
    var items: [Transaction] { get }
    var allItems: [Transaction] { get async throws }
    
    mutating func addItem(_ transaction: Transaction)
}

struct Store: StoreProvider {
    internal var items: [Transaction] = []
    
    var allItems: [Transaction] {
        items
    }
    
    mutating func addItem(_ item: Transaction) {
        items.append(item)
    }
}

struct MockStore: StoreProvider {
    internal var items: [Transaction] = Transaction.mockItems
    
    var allItems: [Transaction] {
        items
    }
    
    mutating func addItem(_ item: Transaction) {
        items.append(item)
    }
}

// Injection
private struct StoreKey: InjectionKey {
    static var currentValue: any StoreProvider = Store()
}

extension InjectedValues {
    var store: any StoreProvider {
        get { Self[StoreKey.self] }
        set { Self[StoreKey.self] = newValue }
    }
}
