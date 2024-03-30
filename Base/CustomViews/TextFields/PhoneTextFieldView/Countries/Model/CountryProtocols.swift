//
//  CountryProtocols.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import Foundation

protocol CountryCodeItem {
    var id: Int? {get}
    var name: String {get}
    var flag: String? {get}
    var emoji: String? {get}
    var countryCode: String? {get}
}
protocol CountryCodeDelegate {
    func didSelectCountry(_ item: CountryCodeItem)
}

