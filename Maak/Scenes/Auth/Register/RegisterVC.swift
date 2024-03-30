//
//  RegisterVCVC.swift
//  Maak
//
//  Created by AAIT on 26/12/2023.
//

import UIKit

final class RegisterVC: BaseVC {
    // MARK: - IBOutlets -
    @IBOutlet private var firstNameTF: AppTextField!
    @IBOutlet private var lastNameTF: AppTextField!
    @IBOutlet private var userNameTF: AppTextField!
    @IBOutlet private var countryCodePicker: CountriesStackView!
    @IBOutlet private var countryCodeLabel: UILabel!
    @IBOutlet private var countryImage: UIImageView!
    @IBOutlet private var phoneNumberTF: AppTextField!
    @IBOutlet private var emailTF: AppTextField!
    @IBOutlet var regionTF: AppTextField!
    @IBOutlet var regionPicker: AppPickerTextFieldStyle!
    @IBOutlet private var cityTF: AppTextField!
    @IBOutlet private var cityPicker: AppPickerTextFieldStyle!
    @IBOutlet private var nationalityTF: AppTextField!
    @IBOutlet private var nationalityPicker: AppPickerTextFieldStyle!
    @IBOutlet private var passwordTF: AppTextField!
    @IBOutlet private var confirmPassword: AppTextField!
    @IBOutlet private var termsAndConditionsButton: UIButton!
    @IBOutlet private var acceptTermsButton: UIButton!

    
    private var countryCode: String = ""
    private var selectedRegionId: Int?
    private var selectedCityId: Int?
    
    // MARK: - Init -

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialDesign()
        getCountries()
     }

    // MARK: - Design Methods -

    private func configureInitialDesign() {
        title = "Create new account".localized
        termsAndConditionsButton.addUnderLine(text: "I agree to the terms and conditions".localized, fontSize: 15, color: UIColor(resource: .mainDarkFont))
        setupPickers()
        phoneNumberTF.textField.keyboardType = .numberPad
        countryCodePicker.delegate  = self
    }

    private func setupPickers() {
        regionPicker.borderStyle = .none
        regionPicker.didSelected = { [weak self] region in
            guard let self else { return }
            selectedRegionId = region.pickerId
            regionTF.textField.text = region.pickerTitle
            getCitiesByRegion(regionId: region.pickerId)
            selectedCityId = nil
        }
        
        
        cityPicker.borderStyle = .none
        cityPicker.didSelected = { [weak self] city in
            guard let self else { return }
            cityTF.textField.text = city.pickerTitle
            selectedCityId = city.pickerId
        }

        nationalityPicker.borderStyle = .none
        nationalityPicker.didSelected = { [weak self] country in
            guard let self else { return }
            nationalityTF.textField.text = country.pickerTitle
        }
    }

    // MARK: - Logic Methods -

    // MARK: - Actions -

    @IBAction private func termsButtonWasPressed(_ sender: UIButton) {
        AppCoordinator.shared.authNavigator?.navigate(destination: .terms, mode: .push)
    }

    @IBAction private func acceptTermsButtonWasPressed(_ sender: UIButton) {
        acceptTermsButton.isSelected = !sender.isSelected
    }

    @IBAction private func registerWasPressed(_ sender: UIButton) {
        validate()
    }
}

// MARK: - Validation -

extension RegisterVC {
    private func validate() {
        do {
            let firstName = try ValidationService.validate(firstName: firstNameTF.textField.text)
            let lastName = try ValidationService.validate(lastName: lastNameTF.textField.text)
            let userName = try ValidationService.validate(userName: userNameTF.textField.text)
            let phoneNumber = try ValidationService.validate(phone: phoneNumberTF.textField.text)
            let email = try ValidationService.validate(email: emailTF.textField.text)
            let _ = try ValidationService.validate(regionId: selectedRegionId)
            let cityId = try ValidationService.validate(cityId: selectedCityId)
            let countryId = try ValidationService.validate(countryId: nationalityPicker.selectedPickerData?.pickerId)
            let password = try ValidationService.validate(password: passwordTF.textField.text)
            let confirmPassword = try ValidationService.validate(newPassword: password, confirmPassword: confirmPassword.textField.text)
            _ = try ValidationService.validate(termsAgreed: acceptTermsButton.isSelected)

            registerAPI(firstName: firstName,
                        lastName: lastName,
                        userName: userName,
                        countryCode: "+966",
                        phone: phoneNumber,
                        email: email,
                        cityId: cityId,
                        countryId: countryId,
                        password: confirmPassword)

        } catch {
            showErrorToast(with: error.localizedDescription)
        }
    }
}

extension RegisterVC: CountryCodeStackDelegate{
    
    func didChooseCountry(country: Country) {
        self.countryCodeLabel.text = country.key
        self.countryImage.setWith(url: country.image)
        self.getRegions(countryId: country.id)
        self.selectedRegionId = nil
        self.regionTF.textField.text = nil
        self.selectedCityId = nil
        self.cityTF.textField.text = nil

    }
    

}




// MARK: - Networking -

extension RegisterVC {
    
    // MARK: - RegisterAPI -

    private func registerAPI(firstName: String, lastName: String, userName: String, countryCode: String, phone: String, email: String, cityId: Int, countryId: Int, password: String) {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await AuthServices.register(firstName: firstName,
                                                        lastName: lastName,
                                                        userName: userName,
                                                        phone: phone,
                                                        email: email,
                                                        cityId: cityId,
                                                        password: password,
                                                        countryId: countryId,
                                                        countryCode: countryCode).send(dataType: User.self)
                
                self.showSuccessToast(with:  response.message)

                AppCoordinator.shared.authNavigator?.navigate(destination: .verification(phone: phone, countryCode: countryCode, useCase: .activation), mode: .push)

            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
    }

    // MARK: - GetCountries -
    private func getCountries() {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await AuthServices.countries.send(dataType: [Country].self)
                
                
                self.countryCodePicker.countries = response.data ?? []
                self.countryCodeLabel.text = response.data?[0].key
                self.countryImage.setWith(url: response.data?[0].image)
                
                self.nationalityPicker.setupData(data: response.data ?? [])
                
                response.data?.isEmpty == false ?   self.getRegions(countryId:  response.data?[0].id ?? 0) : ()
              

                
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
            AppIndicator.shared.dismiss()

        }
    }
    
    // MARK: - GetRegions -

    private func getRegions(countryId: Int) {
        Task {
            do {
                let response = try await MoreServices.regionsByCountry(countryId: countryId).send(dataType: [City].self)
                regionPicker.setupData(data: response.data ?? [])
             } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
    }
    

    private func getCitiesByRegion(regionId: Int) {
        Task {
            do {
                let response = try await MoreServices.citiesByRegion(regionId: regionId).send(dataType: [City].self)
                cityPicker.setupData(data: response.data ?? [])
                cityTF.textField.text = cityPicker.dataSorce.first(where: {$0.pickerId == selectedCityId })?.pickerTitle
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
    }
}
