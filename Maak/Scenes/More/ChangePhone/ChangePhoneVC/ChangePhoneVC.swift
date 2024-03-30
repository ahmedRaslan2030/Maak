//
//  ChangePhoneVC.swift
//  Maak
//
//  Created by AAIT on 13/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class ChangePhoneVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet weak private var checkPasswordView: UIView!
    @IBOutlet weak private var newPhoneNumberView: UIView!
    @IBOutlet weak private var passwordTF: AppTextField!
    @IBOutlet weak private var phoneTF: AppTextField!
    
    @IBOutlet weak private var countryCodeLabel: UILabel!
    @IBOutlet weak private var countryImage: UIImageView!
    @IBOutlet weak private var countriesStack: CountriesStackView!
    //MARK: - Properties -
    
   
    
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
        self.title = "Change Phone Number".localized
        countriesStack.delegate  = self
        phoneTF.textField.keyboardType = .numberPad
    }
    
    
    //MARK: - Actions -
    
    @IBAction func checkPasswordAction(_ sender: UIButton) {
        do{
            let password = try ValidationService.validate(password: passwordTF.textField.text)
            checkPassword(password: password)
            
        }catch{
            self.showErrorToast(with: error.localizedDescription)
        }
    }
    
    @IBAction func changePhoneNumberAction(_ sender: UIButton) {
        do{
            
            let phone = try ValidationService.validate(phone: phoneTF.textField.text)
            changePhone(countryCode: countryCodeLabel.text ?? "", phone: phone, password: passwordTF.textField.text ?? "")
        }catch{
            self.showErrorToast(with: error.localizedDescription)
        }
    }
    
}

// MARK: - CountryCodeStackDelegate -

extension ChangePhoneVC: CountryCodeStackDelegate{
    
    func didChooseCountry(country: Country) {
        self.countryCodeLabel.text = country.key
        self.countryImage.setWith(url: country.image)
    }
    

}




//MARK: - Networking -
extension ChangePhoneVC {
    
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
    
    
    private func checkPassword(password: String) {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await MoreServices.checkPassword(password: password).send(dataType: String?.self)
                self.showSuccessToast(with: response.message)

                checkPasswordView.isHidden = true
                newPhoneNumberView.isHidden = false
                self.title = "New Phone Number".localized

 
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
   }
    
    
    private func changePhone(countryCode: String, phone: String ,password: String) {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                
                
                let response = try await MoreServices.changePhoneSendCode(countryCode: countryCode, phone: phone, password: password).send(dataType: String?.self)
                self.showSuccessToast(with: response.message)
                
                AppCoordinator.shared.moreNavigator?.navigate(destination: .verification(phone: phone, countryCode: countryCode, password: password), mode: .present, modalPresentationStyle: .custom , modalTransitionStyle: .crossDissolve)
                
 
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
   }
}

 
