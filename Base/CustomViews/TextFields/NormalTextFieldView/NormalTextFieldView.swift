//
//  NormalTextFieldView.swift
//  WithYou
//
//  Created by Ahmed Raslan on 25/10/2023.
//

import UIKit

class NormalTextFieldView: TextFieldView {
    
    //MARK: - IBOutlet -
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var requiredLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var sRLabel: UILabel!
    
    //MARK: - Properties -
    @IBInspectable var image: UIImage? {
        didSet {
            self.imageView.image = image?.withRenderingMode(.alwaysTemplate)
            self.imageView.isHidden = self.image == nil
        }
    }
    @IBInspectable var isNumericKeyboard: Bool = false {
        didSet {
            self.textField.keyboardType = isNumericKeyboard ? .asciiCapableNumberPad : .default
        }
    }
    @IBInspectable var titleLocalizedKey: String? {
        didSet {
            self.titleLabel.xibLocKey = titleLocalizedKey
        }
    }
    @IBInspectable var placeholderLocalizedKey: String? {
        didSet {
            self.textField.xibPlaceholderLocKey = placeholderLocalizedKey
        }
    }
    @IBInspectable var isRequired: Bool = true {
        didSet {
            self.requiredLabel.isHidden = self.isRequired
        }
    }
    
    var onChangeTextValue: ((String?)->())?
    
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
        let nib = UINib(nibName: "NormalTextFieldView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
        
    }
    
    //MARK: - Design -
    private func setupInitialDesign() {
        self.setupTextField()
        self.setupContainerView()
        self.imageView.isHidden = true
        self.contentView.backgroundColor = UIColor(resource: .textFieldBackground)
    }
    private func setupContainerView() {
        self.containerView.layer.cornerRadius = containerViewCornerRadius
        self.containerView.clipsToBounds = true
        self.setInactiveState()
    }
    private func setupTextField() {
        self.textField.delegate = self
    }
    private func setActiveState() {
        UIView.animate(withDuration: 0.2) {
            self.containerView.addActiveBorder()
            self.tintColor = self.activeTintColor
        }
    }
    private func setInactiveState() {
        UIView.animate(withDuration: 0.2) {
            self.containerView.addInactiveBorder()
            self.tintColor = self.inActiveTintColor
        }
    }
    
    //MARK: - Encapsulation -
    func set(text: String?) {
        guard let text, !text.trimWhiteSpace().isEmpty else {
            self.textField.text = nil
            self.setInactiveState()
            return
        }
        self.textField.text = text
        self.setActiveState()
    }
    func textValue() -> String? {
        self.textField.textValue
    }
    
    //MARK: - Actions -
    @IBAction func textDidChange(_ sender: UITextField) {
        self.onChangeTextValue?(sender.text)
    }
    
    
}

extension NormalTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.setActiveState()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.trimWhiteSpace().isEmpty else {
            self.setInactiveState()
            return
        }
        self.setActiveState()
    }
}
