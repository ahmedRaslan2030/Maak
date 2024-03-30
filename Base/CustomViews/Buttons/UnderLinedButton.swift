//
//  UnderLinedButton.swift
//  WithYou
//
//  Created by Ahmed Raslan on 31/08/2023.
//

import UIKit

class UnderLinedButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        let title = (self.currentTitle ?? "").localized
        let attributedString = title.changeWithUnderLine(strings: [title], with: UIColor(resource: .mainDarkFont))
        self.setAttributedTitle(attributedString, for: .normal)
        self.setAttributedTitle(attributedString, for: .selected)
    }
    
    
}


