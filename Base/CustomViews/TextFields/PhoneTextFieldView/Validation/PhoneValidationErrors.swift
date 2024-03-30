//
//  PhoneValidationErrors.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import Foundation

enum PhoneValidationErrors: Error {
    case emptyPhone
    case inValidPhone
    case emptyCountryCode
}
extension PhoneValidationErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyPhone:
            return "Please enter your phone number.".phoneNumberLocalizable
        case .inValidPhone:
            return "Please enter correct phone number.".phoneNumberLocalizable
        case .emptyCountryCode:
            return "Please select your country code.".phoneNumberLocalizable
        }
    }
}
