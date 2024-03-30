//
//  PhoneValidationService.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import Foundation

struct PhoneValidationService {
    static func validate(phone: String?) throws -> String {
        guard let phone = phone, !phone.trimWhiteSpace().isEmpty else {
            throw PhoneValidationErrors.emptyPhone
        }
        guard phone.count > 8 else {
            throw PhoneValidationErrors.inValidPhone
        }
        return phone
    }
    static func validate(countryCode: String?) throws -> String {
        guard let countryCode = countryCode, !countryCode.trimWhiteSpace().isEmpty else {
            throw PhoneValidationErrors.emptyCountryCode
        }
        return countryCode
    }
}

