//
//  Gradient.swift
//  WithYou
//
//  Created by MacOS on 20/09/2023.
//

import Foundation
import UIKit

class BackGroundGradiantColor: UIView {

    private var gradientLayer = CAGradientLayer()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.addGradientLayer()
    }
    private func addGradientLayer() {

        if gradientLayer.superlayer != nil {
            gradientLayer.removeFromSuperlayer()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let colorTop =  UIColor(red: 100/255.0, green: 153/255.0, blue: 243/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 65/255.0, green: 207/255.0, blue: 170/255.0, alpha: 1.0).cgColor
            self.gradientLayer.colors = [colorTop, colorBottom]
            self.gradientLayer.frame = self.bounds
            self.layer.insertSublayer(self.gradientLayer, at: 0)
        }
    }
}
