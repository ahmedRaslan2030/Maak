//
//  AppButton.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import UIKit

class AppButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        self.addCorner()
        self.backgroundColor = UIColor(resource: .main)
        self.setTitleColor(.white, for: .normal)
    }
}


class AppRedButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        self.addCorner()
        self.backgroundColor = .red
        self.setTitleColor(.white, for: .normal)
    }
}

class AppGreenButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        self.addCorner()
        self.backgroundColor = UIColor(resource: .secondary)
        self.setTitleColor(.white, for: .normal)
    }
}

class AppGreyButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        self.addCorner()
        self.backgroundColor = .systemGray6
        self.setTitleColor(UIColor(resource: .secondaryLightFont), for: .normal)
    }
}

