//
//  DashboardViewModel.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import Foundation

enum ViewState {
    case loading
    case loaded([Currency])
    case failed(Error)
}

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var loadingState: ViewState = .loading
    @Published var showingHistory = false
    @Published var currency: Currency? = nil
    @Published var selectedAmountIndex = 0
    
    @Injected(\.store) var store: StoreProvider
    

    /**
     * Dashboard
     */
    @Sendable
    func fetchCurrencies() async {
        do {
            let items = try await Currency.all
            loadingState = .loaded(items)
        } catch {
            loadingState = .failed(error)
        }
    }
    
    /**
     * Currency buy sheet
     */
    var amountSegments: [Decimal] {
        [5000, 25000, 50000, 75000]
    }
    
    var purchaseValue: String {
        let value = amountSegments[selectedAmountIndex]/(currency?.price ?? 0)
        return value.formatted(.number.precision(.fractionLength(8)))
    }
    
    var transactions: [Transaction] {
        store.items
    }
    
    var totalAmount: String {
        store.items.sum(\.amount).usd
    }
    
    func showBuyForm(item: Currency) {
        currency = item
    }
    
    func buy() {
        guard let currency = currency else {
            return
        }

        store.addItem(
            Transaction(date: Date.now,
                        amount: amountSegments[selectedAmountIndex],
                        currency: currency)
        )
        
        cancelBuy()
        showHistory()
    }
    
    func cancelBuy() {
        currency = nil
    }
    
    /**
     * History sheet
     */
    var isHistoryAvailable: Bool {
        store.items.count < 1
    }
    
    func showHistory() {
        showingHistory.toggle()
    }
}
