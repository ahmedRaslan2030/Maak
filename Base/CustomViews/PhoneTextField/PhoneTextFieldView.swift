//  
//  PhoneTextField.swift
//  Artist
//
//  Created by Ahmed Raslan on 31/10/2023.
//

import UIKit

final class PhoneTextFieldView: UIView {
    
    let XIB_NAME = "PhoneTextFieldView"
    
    // MARK: - outlets -
    @IBOutlet weak private(set) var countryCodeStackView: CountriesStackView!
    @IBOutlet weak private(set) var countryImage: UIImageView!
    @IBOutlet weak private(set) var countryCode: UILabel!
    @IBOutlet weak private(set) var phoneNumber: UITextField!
    
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Design -
    
    private func commonInit() {
        guard let xib = Bundle.main.loadNibNamed(XIB_NAME, owner: self, options: nil)?.first, let viewFromXib = xib as? UIView else { return }
        viewFromXib.frame = bounds
        addSubview(viewFromXib)
        setupInitialDesign()
    }
    
    private func setupInitialDesign(){
        self.countryCodeStackView.delegate = self
        self.phoneNumber.delegate = self
        phoneNumber.placeholder = "Please enter your phone number.".phoneNumberLocalizable
    }
    
    
    func configView(countries: [Country]){
        self.countryCodeStackView.countries = countries
        self.countryImage.setWith(url: countries[0].image)
        self.countryCode.text = "+966"
    }
}

extension PhoneTextFieldView: CountryCodeStackDelegate{
    
    func didChooseCountry(country: Country) {
        self.countryCode.text = country.key
        self.countryImage.setWith(url: country.image)
    }
}


extension PhoneTextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderWidth = 1
        self.layer.borderColor =  UIColor(resource: .main).cgColor
        self.addCorner(8.0)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor =  UIColor(resource: .border).cgColor
        self.layer.borderWidth = 1
    }
}
