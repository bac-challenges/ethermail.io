//
//  Sequence+Utils.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import Foundation

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element {
        reduce(.zero, +)
    }
}

extension Sequence {
    func sum<T: AdditiveArithmetic>(_ keyPath: KeyPath<Element, T>) -> T {
        map { $0[keyPath: keyPath] }.sum()
    }
}
