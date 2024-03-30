//
//  AppTextField.swift
//  Maak
//
//  Created by Ahmed Raslan® on 26/12/2023.
//

import MaterialComponents

@IBDesignable
class AppTextField: UIView {
    // MARK: - Properties

 private (set) var textField: MDCOutlinedTextField = {
        let textField = MDCOutlinedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let secureToggleImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "eye"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    // MARK: - IBAttributes

    @IBInspectable
    var cornersRadius: CGFloat = 8.0 {
        didSet { updateCornerRadius() }
    }

    // texts and fonts
    @IBInspectable
    var labelText: String = "" {
        didSet { updateLabelText() }
    }

    @IBInspectable
    var labelTextColor: UIColor = .label {
        didSet { updateLabelText() }
    }

    @IBInspectable
    var fontSize: CGFloat = 15.0 {
        didSet { updateFontSize() }
    }

    // placeHolders

    @IBInspectable
    var placeHolderWhileEditing: String = "" {
        didSet { updatePlaceHolderWhileEditing() }
    }

    @IBInspectable
    var placeHolderWhileNormal: String = "" {
        didSet { updatePlaceHolderWhileNormal() }
    }

    // backgroundColors

    @IBInspectable
    var backgroundColorWhileEditing: UIColor = .white {
        didSet { updateBackgroundColorWhileEditing() }
    }

    @IBInspectable
    var backgroundColorNormal: UIColor = .systemBackground {
        didSet { updateBackgroundColorWhileNormal() }
    }

    // borderColors

    @IBInspectable
    var borderColorWhileEditing: UIColor = .black {
        didSet { updateOutlineColor() }
    }

    @IBInspectable
    var borderColorWhileNormal: UIColor = .clear {
        didSet { updateBackgroundColorWhileNormal() }
    }

    // side icons
    @IBInspectable
    var leadingImage: UIImage? {
        didSet { updateLeadingImage() }
    }

    @IBInspectable
    var trailingImage: UIImage? {
        didSet { updateTrailingImage() }
    }

    @IBInspectable
    var leadingViewMode: UITextField.ViewMode = .whileEditing {
        didSet { updateLeadingViewMode() }
    }

    @IBInspectable
    var trailingViewMode: UITextField.ViewMode = .unlessEditing {
        didSet { updateTrailingViewMode() }
    }

    // isSecureEntry

    @IBInspectable
    var isSecureEntery: Bool = false {
        didSet {
            isSecureEntery == true ? setupSecureToggle() : ()
        }
    }
    
    
    @IBInspectable
    var isDateField: Bool = false {
        didSet {
            isDateField == true ? setupDateField() : ()
        }
    }
    
    
    @IBInspectable
    var isDocumentPicker: Bool = false {
        didSet {
            isDocumentPicker == true ? setupDocumentPicker() : ()
        }
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    convenience init(
        placeHolder: String = "",
        cornerRadius: CGFloat = 8.0,
        backgroundColorNormal: UIColor = .systemBackground,
        outlineBorderColor: UIColor = .systemBackground,
        fontSize: CGFloat = 15.0,
        leadingImage: UIImage? = nil,
        trailingImage: UIImage? = nil,
        leadingViewMode: UITextField.ViewMode = .whileEditing,
        trailingViewMode: UITextField.ViewMode = .unlessEditing
    ) {
        self.init()
        placeHolderWhileNormal = placeHolder
        cornersRadius = cornerRadius
        self.backgroundColorNormal = backgroundColorNormal
        borderColorWhileNormal = outlineBorderColor
        self.fontSize = fontSize
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.leadingViewMode = leadingViewMode
        self.trailingViewMode = trailingViewMode
    }

    // MARK: - Common Initialization

    private func commonInit() {
        addSubview(textField)
        textField.delegate = self
        setupConstraints()
        applyDefaultStyles()
    }

    // MARK: - Layout

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])

         /// for more info  visit : https://github.com/material-components/material-components-ios/issues/9291

        textField.verticalDensity = 1.0
    }

    // MARK: - Default Styles

    private func applyDefaultStyles() {
        updateSecureToggleState()
        updateBackgroundColorWhileNormal()
        updateBorderColorWhileNormal()
        updateFontSize()
        updatePlaceHolderWhileNormal()
        updateLabelText()
        updateCornerRadius()
        updateFontSize()
        updateLeadingImage()
        updateTrailingImage()
        updateLeadingViewMode()
        updateTrailingViewMode()
        setupSecureToggle()
    }

    // MARK: - Private setters

    private func setupSecureToggle() {
            textField.trailingView = secureToggleImageView
            textField.trailingViewMode = .always
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSecureTextEntry))
            secureToggleImageView.addGestureRecognizer(tapGesture)
            updateSecureToggleState()
    }

    @objc private func toggleSecureTextEntry() {
        isSecureEntery.toggle()
        updateSecureToggleState()
    }

    private func updateSecureToggleState() {
            textField.isSecureTextEntry = isSecureEntery
            let imageName = isSecureEntery ? "eye.slash" : "eye"
            secureToggleImageView.image = UIImage(systemName: imageName)
            textField.trailingView = secureToggleImageView
        
    }
    
    
    private func setupDateField() {
    textField.leadingViewMode = .never
    textField.trailingViewMode = .always
   }
    
    private func setupDocumentPicker() {
    textField.leadingViewMode = .never
    textField.trailingViewMode = .always
   }

    private func updateLabelText() {
        textField.label.text = labelText.localized
    }

    private func updatePlaceHolderWhileNormal() {
        textField.placeholder = placeHolderWhileNormal.localized
    }

    private func updatePlaceHolderWhileEditing() {
        textField.placeholder = placeHolderWhileEditing.localized
    }

    private func updateCornerRadius() {
        textField.layer.cornerRadius = cornersRadius
    }

    private func updateFontSize() {
        textField.font = UIFont.systemFont(ofSize: fontSize)
    }

    private func updateBackgroundColorWhileNormal() {
        textField.backgroundColor = backgroundColorNormal
    }

    private func updateBorderColorWhileNormal() {
        textField.setOutlineColor(borderColorWhileNormal, for: .normal)
    }

    private func updateBackgroundColorWhileEditing() {
        textField.backgroundColor = backgroundColorWhileEditing
    }

    private func updateOutlineColor() {
        textField.setOutlineColor(borderColorWhileEditing, for: .editing)
    }

    private func updateLeadingImage() {
        let imageView = UIImageView(image: leadingImage)
        imageView.contentMode = .center
        textField.leadingView = imageView
    }

    private func updateTrailingImage() {
        let imageView = UIImageView(image: trailingImage)
        imageView.contentMode = .center
        textField.trailingView = imageView
    }

    private func updateLeadingViewMode() {
        textField.leadingViewMode = leadingViewMode
    }

    private func updateTrailingViewMode() {
        textField.trailingViewMode = trailingViewMode
    }
}

// MARK: - UITextFieldDelegate Methods

extension AppTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField.label.isHidden = false
        updateOutlineColor()
        updateBackgroundColorWhileEditing()
        updatePlaceHolderWhileEditing()
        if isSecureEntery == true{
            let imageView = UIImageView(image: trailingImage)
            imageView.contentMode = .center
            self.textField.trailingView = secureToggleImageView
        }
        
        if isDateField || isDocumentPicker {
            let imageView = UIImageView(image: trailingImage?.withTintColor(UIColor(resource: .secondary)))
            imageView.contentMode = .center
         }
        
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textField.label.isHidden = true
        updateBorderColorWhileNormal()
        updateBackgroundColorWhileNormal()
        updatePlaceHolderWhileNormal()
        if isSecureEntery == true{
            self.updateTrailingImage()
        }
        
   
    }
}


