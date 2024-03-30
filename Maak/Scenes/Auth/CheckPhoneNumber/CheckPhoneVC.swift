//
//  CheckPhoneVC.swift
//  Maak
//
//  Created by AAIT on 03/01/2024.
//

import UIKit

final class CheckPhoneVC: BaseVC {
    // MARK: - IBOutlets -

    @IBOutlet private var phoneTextFieldView: PhoneTextFieldView!

    // MARK: - Init -

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reset password".localized
        setBackTitle("Reset password".localized)
        getCountries()
    }

    // MARK: - IBActions -

    @IBAction private func confirmButtonWasPressed(_ sender: UIButton) {
        validation()
    }
}

// MARK: - Validation-

extension CheckPhoneVC {
    private func validation() {
        do {
            let phoneNumber = try ValidationService.validate(phone: phoneTextFieldView.phoneNumber.text)
            let countryCode = try ValidationService.validate(countryCode: phoneTextFieldView.countryCode.text)
            forgetPasswordCheckPhone(countryCode: countryCode, phone: phoneNumber)
        } catch {
            showErrorToast(with: error.localizedDescription)
        }
    }
}

// MARK: - NetWorking-

extension CheckPhoneVC {
    // MARK: - GetCountries -

    private func getCountries() {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await AuthServices.countries.send(dataType: [Country].self)

                phoneTextFieldView.configView(countries: response.data ?? [])

            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
    }

    // MARK: - ForgetPasswordCheckPhone -

    private func forgetPasswordCheckPhone(countryCode: String, phone: String) {
        
            AppIndicator.shared.show(isGif: false)
            Task {
                do {
                    let response = try await AuthServices.forgetPasswordSendCode(countryCode: countryCode, phone: phone).send(dataType: String?.self)

                    self.showSuccessToast(with: response.message)

                    AppCoordinator.shared.authNavigator?.navigate(destination: .verification(phone: phone, countryCode: phoneTextFieldView.countryCode.text ?? "", useCase: .forgetPassword), mode: .push)

                } catch {
                    self.showErrorToast(with: error.localizedDescription)
                }
                AppIndicator.shared.dismiss()

            }
        
    }
}
