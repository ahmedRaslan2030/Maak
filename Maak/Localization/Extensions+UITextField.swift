//
//  Extensions+UITextField.swift
//
//  Created by Ahmed Raslan®
//

import UIKit

//MARK:- Localization
extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if Language.isRTL() {
            if textAlignment == .natural {
                self.textAlignment = .right
            }
        } else {
            if textAlignment == .natural {
                self.textAlignment = .left
            }
        }
    }
}



extension UITextField {
    var textValue: String? {
        guard let word = text?.trimWhiteSpace(), !word.isEmpty else {
            return nil
        }
        return word
    }
}
