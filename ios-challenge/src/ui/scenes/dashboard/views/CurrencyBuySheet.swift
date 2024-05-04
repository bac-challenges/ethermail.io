//
//  CurrencyBuySheet.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import SwiftUI

struct CurrencyBuySheet: View {
    
    @EnvironmentObject
    private var viewModel: DashboardViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            if let currency = viewModel.currency {
                CurrencyView(item: currency)
                
                Spacer()
                Text("\(currency.symbol) \(viewModel.purchaseValue)")
                    .foregroundColor(.blue)
                    .font(.title)
                Spacer()
                
                Picker("Amount", selection: $viewModel.selectedAmountIndex) {
                    ForEach(0..<viewModel.amountSegments.count, id: \.self) { index in
                        Text(viewModel.amountSegments[index].usd).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Button(action: buy) {
                    HStack {
                        Spacer()
                        Text("Buy").font(.title3)
                        Spacer()
                    }
                    .padding(10)
                }
                .foregroundColor(.white)
                .background(Color.blue)
                
                Button("Cancel", role: .cancel, action: cancelBuy)
            } else {
                Text("Currency selection error.")
            }
        }
        .presentationDragIndicator(.visible)
        .presentationDetents([.fraction(0.45)])
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Buy")
        .padding(20)
    }
    
    private func buy() {
        viewModel.buy()
    }
    
    private func cancelBuy() {
        viewModel.cancelBuy()
    }
}

#Preview {
    let viewModel = DashboardViewModel()
    viewModel.store = MockStore()
    viewModel.currency = Currency.mockBitCoin
    
    return CurrencyBuySheet().environmentObject(viewModel)
}
