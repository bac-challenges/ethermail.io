//
//  CurrencyRow.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import SwiftUI

struct CurrencyRow: View {
    
    @EnvironmentObject
    var viewModel: DashboardViewModel
    
    let item: Currency
    
    var body: some View {
        Button(action: showBuyForm) {
            CurrencyView(item: item)
        }
    }
    
    private func showBuyForm() {
        viewModel.showBuyForm(item: item)
    }
}

#Preview {
    CurrencyRow(item: Currency.mockBitCoin)
}
