//
//  CurrencyView.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import SwiftUI

struct CurrencyView: View {
    
    let item: Currency
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            
            // Symbol
            AsyncImage(url: URL(string: item.icon)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 30, height: 30)
            
            VStack(spacing: 8) {
                HStack(alignment: .bottom, spacing: 2) {
                    Text("\(item.name) ")
                        .foregroundColor(.blue)
                    Spacer()
                    Text(item.price.usd)
                        .foregroundColor(.blue)
                }
                
                HStack(spacing: 2) {
                    Text(item.symbol)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    
                    Spacer()
                    Text(item.change, format: .percent.precision(.fractionLength(2)))
                        .foregroundColor(item.change > 0 ? .green:.red)
                        .font(.footnote)
                    
                    Image(systemName: item.change > 0 ? "arrow.up":"arrow.down")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .foregroundColor(item.change > 0 ? .green:.red)
                }
            }
        }
    }
}

#Preview {
    CurrencyView(item: Currency.mockBitCoin)
}
