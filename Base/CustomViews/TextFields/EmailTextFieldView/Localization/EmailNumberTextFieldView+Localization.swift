//
//  EmailNumberTextFieldView+Localization.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import Foundation

extension String {
    var emailTitleLocalizable: String {
        return NSLocalizedString(self, tableName: "EmailLocalizable", bundle: Bundle.main, value: "", comment: "")
    }
    
    /*var emailPlaceholderLocalizable: String {
        return NSLocalizedString(self, tableName: "EmailLocalizable", bundle: Bundle.main, value: "", comment: "")
    }*/
}

