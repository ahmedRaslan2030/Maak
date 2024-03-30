//
//  UISegmentedControl.swift
//
//  Created by Ahmed Raslan®
//

import UIKit

extension UISegmentedControl {
    func setupSegmented(mainColor: UIColor, font: UIFont, normalColor: UIColor, selectedColor: UIColor) {
        self.layer.borderColor = mainColor.cgColor
        self.layer.borderWidth = 0
        self.selectedSegmentTintColor = mainColor
        self.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: normalColor,
                NSAttributedString.Key.font: font
            ],
            for: UIControl.State.normal
        )
        self.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: selectedColor,
                NSAttributedString.Key.font: font
            ],
            for: UIControl.State.selected
        )
    }
}

