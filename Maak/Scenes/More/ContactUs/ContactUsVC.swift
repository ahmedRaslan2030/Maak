//
//  ContactUsVC.swift
//  Maak
//
//  Created by AAIT on 12/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class ContactUsVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet private weak var nameTF: AppTextField!
    @IBOutlet private weak var phoneTF: AppTextField!
    @IBOutlet private weak var countriesStack: CountriesStackView!
    @IBOutlet private weak var countryCodeLabel: UILabel!
    @IBOutlet private weak var countryImage: UIImageView!
    @IBOutlet private weak var messageTV: AppTextView!
    
 
    
    //MARK: - Init -
 
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureInitialDesign()
        getCountries()
    }
    
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        self.title = "Contact us".localized
        countriesStack.delegate  = self
        phoneTF.textField.keyboardType = .numberPad
    }
    
 
    //MARK: - Actions -

    @IBAction func sendAction(_ sender: Any) {
          validate()
    }
 
}


// MARK: - CountryCodeStackDelegate -

extension ContactUsVC: CountryCodeStackDelegate{
    
    func didChooseCountry(country: Country) {
        self.countryCodeLabel.text = country.key
        self.countryImage.setWith(url: country.image)
    }
    

}


// MARK: - Validation -
extension ContactUsVC {
    private func validate() {
        do {
            let name = try ValidationService.validate(name: nameTF.textField.text)
            
            let phone = try ValidationService.validate(phone: phoneTF.textField.text)
            
            let message = try ValidationService.validate(message: messageTV.textArea.textView.text)
            
            contactUs(name: name, phone: phone, message: message)
            
        } catch {
            self.showErrorToast(with: error.localizedDescription)
        }
    }
}


//MARK: - Networking -
extension ContactUsVC {
    // MARK: - GetCountries -
    private func getCountries() {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await AuthServices.countries.send(dataType: [Country].self)
                
                
                self.countriesStack.countries = response.data ?? []
                self.countryCodeLabel.text = response.data?[0].key
                self.countryImage.setWith(url: response.data?[0].image)
                
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
    }

    // MARK: - ContactUs -
    private func contactUs(name: String , phone: String , message: String) {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response  = try await MoreServices.contactUs(name: name, phone: phone, content: message).send(dataType: String?.self)
                
                self.showSuccessToast(with: response.message)
                self.pop()
      
                
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
    }

    
    
}
