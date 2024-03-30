//
//  ForgetPasswordVC.swift
//  Maak
//
//  Created by AAIT on 03/01/2024.
//

import UIKit

final class ForgetPasswordVC: BaseVC {
    //MARK: - IBOutlets -
    @IBOutlet private weak var newPasswordTextView: AppTextField!
    @IBOutlet private weak var confirmNewPasswordTextView: AppTextField!

    
    //MARK: - Properties -
    private var countryCode: String
    private var phone: String
    private var code: String
    
    //MARK: - Init -
 
    init(phone: String, countryCode: String, code: String) {
        self.phone = phone
        self.code = code
        self.countryCode = countryCode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureInitialDesign()
    }
    
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        self.title = "New password".localized
    }

    
    //MARK: - Actions -
    @IBAction private func saveWasPressed(_ sender: UIButton){
        validation()
    }
}


//MARK: - Validation -
extension ForgetPasswordVC {
    
    private func validation(){
        do{
            
            let newPassword = try ValidationService.validate(newPassword: newPasswordTextView.textField.text)
            
            let confirmNewPassword = try ValidationService.validate(newPassword: newPassword, confirmNewPassword: confirmNewPasswordTextView.textField.text)
            
            resetPassword(countryCode: self.countryCode, phone: self.phone, code: code, password: confirmNewPassword)
            
        }catch{
            self.showErrorToast(with: error.localizedDescription)
        }
    }
}


extension ForgetPasswordVC: FinishPopUpAnimationProtocol {
    func didFinish() {
        AppCoordinator.shared.authNavigator?.navigate(destination: .login, mode: .popToRoot)
    }
}


//MARK: - Networking -
extension ForgetPasswordVC {
    
    private func resetPassword(countryCode: String, phone: String, code: String, password: String) {
        AppIndicator.shared.show(isGif: false)
        Task{
            
            do{
                _ = try await AuthServices.resetPassword(code: code, countryCode: countryCode, phone: phone, password: password).send(dataType: String.self)
                
                
                AppCoordinator.shared.authNavigator?.navigate(destination: .successVC( delegate: self), mode: .present , modalPresentationStyle: .custom, modalTransitionStyle: .crossDissolve )
            }catch {
                showErrorToast(with: error.localizedDescription)
            }
            AppIndicator.shared.dismiss()

        }

    }
}

 
