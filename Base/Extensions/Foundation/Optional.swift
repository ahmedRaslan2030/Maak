//
//  Optional.swift
//
//  Created by Ahmed Raslan®
//

import Foundation

extension Optional where Wrapped == Bool {
    mutating func toggleOptional() -> Bool {
        guard let value = self else {
            return true
        }
        return !value
    }
}
