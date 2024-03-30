//
//  FloatingTextField.swift
//
//  Created by Ahmed Raslan®.
//

import UIKit

class FloatingTextField: UITextField {
    enum Direction {
        case rtl
        case ltr
    }

    // MARK: - Properties -

    var isPassword = true
    var selectedBorderColor: UIColor =  UIColor(resource: .main)
    var normalBorderColor =  UIColor(resource: .border).cgColor
    lazy var padding = (self.direction == .ltr) ? UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15) : UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    var placeholderView: UIView?
    private var tempPlaceholder: String?
    private weak var timer: Timer?
    private lazy var direction: Direction = {
        Language.isRTL() ? .rtl : .ltr
    }()

    @IBInspectable var leadingImage: UIImage? = nil {
        didSet {
            guard let image = leadingImage else { return }
            sideImage(image, imageWidth: 25, padding: 15)
        }
    }

    @IBInspectable var trailingNormalImage: UIImage? = nil {
        didSet {
            setTrailing(trailingNormalImage, imageWidth: 25, padding: 15, notSecureImage: trailingSelectedImage)
        }
    }

    @IBInspectable var trailingSelectedImage: UIImage? = nil {
        didSet {
            setTrailing(trailingNormalImage, imageWidth: 25, padding: 15, notSecureImage: trailingSelectedImage)
        }
    }

    let secureButton = UIButton()
    var errorMessageLabel: UILabel?

    // MARK: - Overriden Properities -

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // MARK: - Overriden Methods -

    override func awakeFromNib() {
        super.awakeFromNib()
        initialConfiguration()
    }

    // MARK: - Design Methods -

    private func initialConfiguration() {
        delegate = self
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = normalBorderColor
        backgroundColor = .clear
        borderStyle = .none
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }

    func handelPlaceholderView() {
        guard let pHolder = placeholder else { return }
        let width = pHolder.width(withConstrainedHeight: 16, font: UIFont(name: "Cairo-Regular", size: 15)!) + 30
        let xPoint = direction == .ltr ? frame.minX + 15 : frame.maxX - 15 - width
        let yPoint = frame.minY - 8
        placeholderView = UIView(frame: CGRect(x: xPoint, y: yPoint, width: width, height: 20))
        placeholderView?.backgroundColor = .clear
    }

    func createLabelView() {
        handelPlaceholderView()
        guard let pHolder = placeholder else { return }
        let width = pHolder.width(withConstrainedHeight: 16, font: UIFont(name: "Cairo-Regular", size: 15)!)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: width, height: 16))
        label.text = placeholder
        label.textColor = selectedBorderColor
        label.font = UIFont(name: "Cairo-Regular", size: 15)
        placeholderView?.addSubview(label)
        guard let _ = placeholderView else { return }

        UIView.transition(with: superview!, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.superview!.addSubview(self.placeholderView!)
            self.placeholderView?.backgroundColor =  UIColor(resource: .mainBackground)
            self.superview!.bringSubviewToFront(self.placeholderView!)
        }, completion: nil)
    }

    func addDesign() {
        layer.borderColor = selectedBorderColor.cgColor
        createLabelView()
        tempPlaceholder = placeholder
        placeholder = nil
    }

    func addDesignForCell() {
        layer.borderColor = selectedBorderColor.cgColor
        createLabelView()
        tempPlaceholder = placeholder
    }

    // MARK: - Alert -

    func showVisualAlert(_ message: String?) {
        timer?.invalidate()
        errorMessageLabel?.removeFromSuperview()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timer?.fire()
        let width = frame.width - 30
        let xPoint = direction == .ltr ? frame.minX + 15 : frame.maxX - 15 - width
        let yPoint = frame.maxY + 5

        errorMessageLabel = UILabel(frame: CGRect(x: xPoint, y: yPoint, width: width, height: 20))
        errorMessageLabel?.font = UIFont(name: "Cairo-Bold", size: 10)
        errorMessageLabel?.textColor = selectedBorderColor
        errorMessageLabel?.text = message

        UIView.transition(with: superview!, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.superview!.addSubview(self.errorMessageLabel!)
            self.superview!.bringSubviewToFront(self.errorMessageLabel!)
        }, completion: nil)
    }

    @objc func fireTimer() {
        layer.borderColor = (layer.borderColor! == normalBorderColor) ? selectedBorderColor.cgColor : normalBorderColor
    }
}

extension FloatingTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField.text?.isEmpty == true else { return }
        timer?.invalidate()
        layer.borderColor = selectedBorderColor.cgColor
        createLabelView()
        tempPlaceholder = placeholder
        placeholder = nil
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text?.isEmpty == true else {
            placeholder = tempPlaceholder
            return
        }
        layer.borderColor = normalBorderColor
        UIView.transition(with: superview!, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.placeholderView?.removeFromSuperview()
            self.errorMessageLabel?.removeFromSuperview()
        }, completion: nil)
        placeholder = tempPlaceholder
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            placeholder = nil
        }
    }
}

extension FloatingTextField {
    func setTrailing(_ image: UIImage?, imageWidth: CGFloat, padding: CGFloat, notSecureImage: UIImage?) {
        secureButton.setTitle(nil, for: .normal)
        secureButton.setImage(image, for: .normal)
        if isPassword {
            secureButton.setImage(notSecureImage, for: .selected)
            secureButton.addTarget(self, action: #selector(toggleSecure), for: .touchUpInside)
        }
        secureButton.imageView?.contentMode = .scaleAspectFit
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: frame.height))
        containerView.addSubview(secureButton)
        secureButton.frame = containerView.frame

//        if self.direction == .rtl {
//            leftView = containerView
//            leftViewMode = .always
//        }else {
        rightView = containerView
        rightViewMode = .always
//        }

        self.padding = (direction == .ltr) ? UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 50) : UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 15)
    }

    func sideImage(_ image: UIImage?, imageWidth: CGFloat, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: frame.height))
        containerView.addSubview(imageView)
        imageView.frame = containerView.frame

        rightView = containerView
        rightViewMode = .always
    }

    @objc func toggleSecure() {
        secureButton.isSelected.toggle()
        isSecureTextEntry = !secureButton.isSelected
    }
}

/*
 How To use?

 The viewController should be the confirm "DropDownTextFieldDelegate" protocol
 */
protocol DropDownItem {
    var id: String { get }
    var name: String { get }
}

protocol DropDownTextFieldDelegate {
    func dropDownList(for textField: UITextField) -> [DropDownItem]
    func didSelect(item: DropDownItem, for textField: UITextField)
}

class DropDownTextField: FloatingTextField {
    // MARK: - Properties -

    private lazy var picker = UIPickerView()
    private var items: [DropDownItem] = []
    private var selectedItem: DropDownItem?
    var dropDownDelegate: DropDownTextFieldDelegate?
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(UIResponderStandardEditActions.cut(_:)) || action == #selector(UIResponderStandardEditActions.delete(_:)) || action == #selector(UIResponderStandardEditActions.select(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

    // MARK: - Lifecycle -

    override func awakeFromNib() {
        super.awakeFromNib()
        setupDesign()
    }

    private func setupDesign() {
        picker.delegate = self
        inputView = picker
        inputView?.clipsToBounds = true
        tintColor = .white
        addDoneButtonOnKeyboard()
    }

    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.tintColor = .white

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done".localized, style: .done, target: self, action: #selector(doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        guard let selectedItem = selectedItem else {
            if let item = items.first {
                text = item.name
                dropDownDelegate?.didSelect(item: item, for: self)
            }
            resignFirstResponder()
            return
        }
        text = selectedItem.name
        dropDownDelegate?.didSelect(item: selectedItem, for: self)
        resignFirstResponder()
    }
}

extension DropDownTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items = dropDownDelegate?.dropDownList(for: self) ?? []
        return items.count
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: items[row].name, attributes: [NSAttributedString.Key.foregroundColor:  UIColor(resource: .secondaryBackground)])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < items.count else { return }
        selectedItem = items[row]
//        self.doneButtonAction()
    }
}
