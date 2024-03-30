//
//  ToastView.swift
//  MVVM-Base
//
//  Created by MGA on 01/07/2023.
//

import UIKit

class ToastView: UIView {
    
    //MARK: - IBOutlets -
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    
    
    //MARK: - Initializer -
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetUp()
        self.setupInitialDesign()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.xibSetUp()
        self.setupInitialDesign()
    }
    
    private func xibSetUp() {
        let view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    private func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ToastView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
        
    }
    private func setupInitialDesign() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
    
    
    
    //MARK: - Data -
    func set(message: ToastManager.Message) {
        
        
        self.backgroundColor = message.backgroundColor
        self.bodyLabel.textColor = message.textColor
        self.titleLabel.textColor = message.textColor
        
        self.imageView.image = message.image
        self.titleLabel.text = message.title
        self.bodyLabel.text = message.body
        
        
        self.imageView.isHidden = message.image == nil
        self.titleLabel.isHidden = message.title == nil
        
    }
    
    
}
