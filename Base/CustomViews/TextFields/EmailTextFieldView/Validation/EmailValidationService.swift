//
//  EmailValidationService.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import Foundation

struct EmailValidationService {
    
    static func validate(email: String?) throws -> String {
        guard let email = email, !email.trimWhiteSpace().isEmpty else {
            throw EmailValidationError.empty
        }
        guard email.isValidEmail() else{
            throw EmailValidationError.wrong
        }
        return email
    }
    
}

