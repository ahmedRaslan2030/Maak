//
//  Int.swift
//  Maak
//
//  Created by AAIT on 03/03/2024.
//

import Foundation

extension Int {
    func toPrice() -> String {
        return String(format: "%.01f", self) + " " + appCurrency
    }
    func toKiloMeter() -> String {
        return String(format: "%.01f", self) + " " + appDistance
    }
    func toString() -> String {
        return String(self)
    }
}
