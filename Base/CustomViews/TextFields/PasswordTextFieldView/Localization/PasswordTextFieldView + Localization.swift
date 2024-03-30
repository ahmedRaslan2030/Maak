//
//  PasswordTextFieldView + Localization.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import Foundation

extension String {
    var passwordLocalizable: String {
        return NSLocalizedString(self, tableName: "PasswordLocalizable", bundle: Bundle.main, value: "", comment: "")
    }
}

