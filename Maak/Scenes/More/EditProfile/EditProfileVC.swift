//
//  EditProfileVC.swift
//  Maak
//
//  Created by AAIT on 13/02/2024.
//
//  Template by Ahmed Raslan®

import UIKit

final class EditProfileVC: BaseVC {
    // MARK: - IBOutlets -

    @IBOutlet var firstNameTF: AppTextField!
    @IBOutlet var lastNameTF: AppTextField!
    @IBOutlet var userNameTF: AppTextField!
    @IBOutlet var emailTF: AppTextField!
    @IBOutlet var regionTF: AppTextField!
    @IBOutlet var regionPicker: AppPickerTextFieldStyle!
    @IBOutlet var cityTF: AppTextField!
    @IBOutlet var cityPicker: AppPickerTextFieldStyle!
    @IBOutlet var nationalityTF: AppTextField!
    @IBOutlet var nationalityPicker: AppPickerTextFieldStyle!

    // MARK: - Properties -
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
        getProfileData()
        getRegions()
        getCountries()
    }

    // MARK: - Design Methods -

    private func configureInitialDesign() {
        title = "Profile Data".localized
        setupPickers()
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
         selectedCityId = city.pickerId
         cityTF.textField.text = city.pickerTitle
        }

        nationalityPicker.borderStyle = .none
        nationalityPicker.didSelected = { [weak self] country in
            guard let self else { return }
            nationalityTF.textField.text = country.pickerTitle
        }
    }

    // MARK: - Logic Methods -

    private func validate() {
        do {
            let firstName = try ValidationService.validate(firstName: firstNameTF.textField.text)
            let lastName = try ValidationService.validate(lastName: lastNameTF.textField.text)
            let userName = try ValidationService.validate(userName: userNameTF.textField.text)
            let email = try ValidationService.validate(email: emailTF.textField.text)
            let cityId = try ValidationService.validate(cityId:  selectedCityId)
            let nationality = try ValidationService.validate(nationality: nationalityTF.textField.text)
            
            updateProfile(firstName: firstName, lastName: lastName, userName: userName, email: email, cityId: cityId, nationality: nationality)
            
        } catch {
            showErrorToast(with: error.localizedDescription)
        }
    }

    // MARK: - Actions -

    @IBAction func saveChangesAction(_ sender: UIButton) {
        validate()
    }
}

extension EditProfileVC: FinishPopUpAnimationProtocol {
    func didFinish() {
        pop()
    }
}

// MARK: - Configuration -

extension EditProfileVC {
    private func setConfiguration(_ user: User) {
        firstNameTF.textField.text = user.firstName
        lastNameTF.textField.text = user.lastName
        userNameTF.textField.text = user.username
        emailTF.textField.text = user.email
        regionTF.textField.text = user.regionName
        nationalityTF.textField.text = user.countryName
        
        selectedRegionId = user.regionId
        regionPicker.selectedPickerData = regionPicker.dataSorce.first(where: {$0.pickerId == selectedRegionId})
        
        cityPicker.selectedPickerData = cityPicker.dataSorce.first(where: {$0.pickerId == UserDefaults.user?.cityID})
        selectedCityId = user.cityID


    }
}

// MARK: - Networking -

extension EditProfileVC {
    private func getProfileData() {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await MoreServices.getProfile.send(dataType: User.self)

                guard let user = response.data else { return }
                AppHelper.saveUserData(user)
                setConfiguration(user)

                getCitiesByRegion(regionId: user.regionId ?? 1)

            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
    }

    private func getRegions() {
        Task {
            do {
                let response = try await MoreServices.regions.send(dataType: [City].self)
                regionPicker.setupData(data: response.data ?? [])
                
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
    }
    
    
    private func getCountries() {
        Task {
            do {
                let response = try await AuthServices.countries.send(dataType: [Country].self)
                nationalityPicker.setupData(data: response.data ?? [])
                
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

    private func updateProfile(firstName: String, lastName: String, userName: String, email: String, cityId: Int, nationality: String) {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await MoreServices.updateProfile(firstName: firstName, lastName: lastName, userName: userName, email: email, cityId: cityId, nationality: nationality).send(dataType: User.self)

                guard let user = response.data else { return }
                AppHelper.saveUserData(user)
                setConfiguration(user)

                AppCoordinator.shared.moreNavigator?.navigate(destination: .appPopUp(useCase: .changePassWordSuccess, delegate: self, animated: true), mode: .present, modalPresentationStyle: .custom, modalTransitionStyle: .crossDissolve)

            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
    }
}
