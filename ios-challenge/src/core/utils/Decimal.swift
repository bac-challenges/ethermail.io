//
//  Decimal.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import Foundation

extension Decimal {
    var usd: String {
        self.formatted(
            .currency(code: "USD")
            .precision(.fractionLength(2))
            .presentation(.narrow)
        )
    }
}
