//
//  AppTextView.swift
//  Maak
//
//  Created by Ahmed Raslan on 15/01/2024.
//

import MaterialComponents

 
@IBDesignable
final class AppTextView: UIView {
    // MARK: - Properties

 private (set) var textArea: MDCOutlinedTextArea = {
        let textField = MDCOutlinedTextArea()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
    
 
    @IBInspectable
    var textLimit: Int = 200 {
        didSet { updateTrailingViewMode() }
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
        self.placeHolderWhileNormal = placeHolder
        self.cornersRadius = cornerRadius
        self.backgroundColorNormal = backgroundColorNormal
        self.borderColorWhileNormal = outlineBorderColor
        self.fontSize = fontSize
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.leadingViewMode = leadingViewMode
        self.trailingViewMode = trailingViewMode
    }

    // MARK: - Common Initialization

    private func commonInit() {
        addSubview(textArea)
        textArea.textView.delegate = self
        setupConstraints()
        applyDefaultStyles()
    }

    // MARK: - Layout

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textArea.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textArea.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
        ])

        textArea.preferredContainerHeight = 150.0
     }

    // MARK: - Default Styles

    private func applyDefaultStyles() {
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
     }

    // MARK: - Private setters

    private func updateLabelText() {
        textArea.label.text = labelText.localized
    }

    private func updatePlaceHolderWhileNormal() {
        textArea.placeholder = placeHolderWhileNormal.localized
    }

    private func updatePlaceHolderWhileEditing() {
        textArea.placeholder = placeHolderWhileEditing.localized
    }

    private func updateCornerRadius() {
        textArea.layer.cornerRadius = cornersRadius
    }

    private func updateFontSize() {
        textArea.textView.font = UIFont.systemFont(ofSize: fontSize)
    }

    private func updateBackgroundColorWhileNormal() {
        textArea.backgroundColor = backgroundColorNormal
    }

    private func updateBorderColorWhileNormal() {
        textArea.setOutlineColor(borderColorWhileNormal, for: .normal)
    }

    private func updateBackgroundColorWhileEditing() {
        textArea.backgroundColor = backgroundColorWhileEditing
    }

    private func updateOutlineColor() {
        textArea.setOutlineColor(borderColorWhileEditing, for: .editing)
    }

    private func updateLeadingImage() {
        let imageView = UIImageView(image: leadingImage)
        imageView.contentMode = .center
        textArea.leadingView = imageView
    }

    private func updateTrailingImage() {
        let imageView = UIImageView(image: trailingImage)
        imageView.contentMode = .center
        textArea.trailingView = imageView
    }

    private func updateLeadingViewMode() {
        textArea.leadingViewMode = leadingViewMode
    }

    private func updateTrailingViewMode() {
        textArea.trailingViewMode = trailingViewMode
    }
}

// MARK: - UITextFieldDelegate Methods

extension AppTextView: UITextViewDelegate {
    
}
