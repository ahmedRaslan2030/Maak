//
//  ToastLocalization.swift
//  WithYou
//
//  Created by Ahmed Raslan on 30/08/2023.
//

import Foundation

extension String {
    var toastLocalization: String {
        return NSLocalizedString(self, tableName: "ToastLocalization", bundle: Bundle.main, value: "", comment: "")
    }
}
