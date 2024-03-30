//
//  PhoneNumberTextFieldView+Localization.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import Foundation

extension String {
    var phoneNumberLocalizable: String {
        return NSLocalizedString(self, tableName: "PhoneNumberLocalizable", bundle: Bundle.main, value: "", comment: "")
    }
    
    var newPhoneNumberLocalizable: String {
        return NSLocalizedString(self, tableName: "PhoneNumberLocalizable", bundle: Bundle.main, value: "", comment: "")
    }
    
}

