//
//  MapInPlace.swift
//  Maak
//
//  Created by AAIT on 12/12/2023.
//

import Foundation


extension MutableCollection {
    mutating func mapInPlace(_ x: (inout Element) -> ()) {
        for i in indices {
            x(&self[i])
        }
    }
}
