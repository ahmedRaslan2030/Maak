//
//  PickerTextField.swift
//  Maak
//
//  Created by AAIT on 23/08/2023.
//

import UIKit

class AppTextFieldStyle: UITextField {
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(resource: .mainDarkFont)])
        tintColor = UIColor(resource: .secondary)
    }
}

protocol GeneralPickerModel {
    var pickerId: Int { get }
    var pickerTitle: String { get }
    var pickerImage: String { get }
    var pickerSlug: String { get }
}

extension AppPickerTextFieldStyle: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSorce.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSorce[row].pickerTitle.localized
    }
}

class AppPickerTextFieldStyle: AppTextFieldStyle {
    
    var pickerView = UIPickerView()
    var datePickerView = UIDatePicker()
    var selectedDate = Date()
    var dataSorce: [GeneralPickerModel] = []
    var currentIndex = Int()
    var didSelected : ((_ model: GeneralPickerModel)->())?

    var selectedPickerData : GeneralPickerModel?
    
    enum PickerType {
        case date
        case time
        case normal
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.delegate = self
        setupNormalPickerView()
    }

    func setupData(data: [GeneralPickerModel]) {
        dataSorce = data
        pickerView.reloadAllComponents()
    }

    private func setupNormalPickerView() {
        pickerView.tintColor = UIColor(resource: .secondary)

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(resource: .main)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Confirm".localized, style: .done, target: self, action: #selector(normalDoneTapped))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        inputView = pickerView
        inputAccessoryView = toolBar
        tintColor = UIColor.clear
    }

    @objc private func normalDoneTapped() {
        if !dataSorce.isEmpty {
            text = dataSorce[pickerView.selectedRow(inComponent: 0)].pickerTitle.localized
            selectedPickerData = dataSorce[pickerView.selectedRow(inComponent: 0)]
            currentIndex = pickerView.selectedRow(inComponent: 0)
            resignFirstResponder()
            guard let data = self.selectedPickerData else { return}
            didSelected?(data)
        }
    }
}

class DatePickerTextField: AppTextFieldStyle {
    
    
    private var datePickerView = UIDatePicker()
    private var selectedDate = Date()
    var didSelected : ((_ date: Date) -> ())?
    var hasMinDate: Bool = true {
        didSet{
            hasMinDate == true ? (datePickerView.minimumDate = Date()): (datePickerView.maximumDate = Date())
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDatePickerView()
    }
    
    private func setupDatePickerView() {
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .inline
        datePickerView.tintColor = UIColor(resource: .main)
        
        

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(resource: .main)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Confirm".localized, style: .done, target: self, action: #selector(dateDoneTapped))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        inputView = datePickerView
        inputAccessoryView = toolBar
        tintColor = UIColor.white
    }

    @objc private func dateDoneTapped() {
        text = datePickerView.date.dateToString
        selectedDate = datePickerView.date
        didSelected?(selectedDate)
        resignFirstResponder()
    }

}

class TimePickerTextField: AppTextFieldStyle {
    
    private var datePickerView = UIDatePicker()
    private var selectedDate = Date()
    var didSelected : ((_ date: Date) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTimePickerView()
    }
    
    // time picker
    private func setupTimePickerView() {
        datePickerView.datePickerMode = .time
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.tintColor = UIColor(resource: .main)

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(resource: .secondary)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Confirm".localized, style: .done, target: self, action: #selector(timeDoneTapped))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        inputView = datePickerView
        inputAccessoryView = toolBar
        tintColor = UIColor.clear
    }

    @objc private func timeDoneTapped() {
        text = datePickerView.date.timeToString
        selectedDate = datePickerView.date
        didSelected?(selectedDate)
        resignFirstResponder()
    }

}

