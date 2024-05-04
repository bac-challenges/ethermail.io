//
//  HistoryRow.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import SwiftUI

struct HistoryRow: View {
    
    let item: Transaction
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            // Name/Rate
            HStack(alignment: .bottom) {
                Text("\(item.currency.name) (\(item.currency.symbol))")
                    .foregroundColor(.blue)
                Spacer()
                Text(item.currency.price.usd)
                    .foregroundColor(.blue)
            }
            
            // Amount/Value
            HStack(alignment: .center, spacing: 5) {
                Text(item.amount.usd)
                Image(systemName: "arrow.right")
                    .foregroundColor(.blue)
                Text(item.amount/item.currency.price,
                     format: .number.precision(.fractionLength(8)))
            }
            
            // Date
            Text(item.date.formatted(date: .long, time: .standard))
                .foregroundColor(.secondary)
                .font(.footnote)
        }
    }
}

#Preview {
    HistoryRow(item: Transaction.mockItem)
}
