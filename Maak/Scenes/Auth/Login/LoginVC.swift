//
//  LoginVC.swift
//  Maak
//
//  Created by AAIT on 26/03/2024.
//

import UIKit
 

final class LoginVC: BaseVC {

    // MARK: - IBOutlets -
     @IBOutlet private weak var userNameTextFieldView: AppTextField!
     @IBOutlet private weak var passwordTextView: AppTextField!
     @IBOutlet private weak var signUpButton: UIButton!
    
    
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
         configUI()
    }
    
    // MARK: - Design -
    private func configUI(){
        self.title = "Login".localized
        setBackTitle("Login".localized)
        signUpButton.addUnderLine(text: "Create new account".localized, fontSize: 14.0, color: UIColor(resource: .secondary))
    }
    
    // MARK: - IBActions -
    
    @IBAction private func forgetPasswordWasPressed(_ sender: UIButton) {
        AppCoordinator.shared.authNavigator?.navigate(destination: .checkPhone, mode: .push)
    }
    
    @IBAction private func loginButtonWasPressed(_ sender: UIButton) {
        validate()
    }
 
    @IBAction private func visitorButtonWasPressed(_ sender: UIButton) {
        AppCoordinator.shared.changeFlow(navigationFlow: .tabBar(selectedIndex: .main))
    }
    
    @IBAction private func registerButtonWasPressed(_ sender: UIButton) {
        AppCoordinator.shared.authNavigator?.navigate(destination: .register, mode: .push)
    }
 
}

// MARK: - Validation-

extension LoginVC {
    
    private func validate() {
        do {
           
            let username = try ValidationService.validate(userName: self.userNameTextFieldView.textField.text)
            let password = try ValidationService.validate(password: passwordTextView.textField.text)
            
            loginAPi(username: username, password: password)
        }
        catch {
            self.showErrorToast(with: error.localizedDescription)
        }
        
    }
    
}


// MARK: - NetWork-

extension LoginVC {
    private func loginAPi(username: String, password: String){
        AppIndicator.shared.show(isGif: false)
        Task{
            do{
                 let response = try await AuthServices.login(userName: username, password: password).send(dataType: User.self)
                
                guard let data = response.data else {return             AppIndicator.shared.dismiss() }
                
                
                if response.key == .needActive {
                    self.showWarningToast(with: response.message)
                    AppCoordinator.shared.authNavigator?.navigate(destination: .verification(phone: data.phone ?? "", countryCode: data.countryCode ?? "" , useCase: .activation), mode: .push)
                    
                }
                else {
                    AppHelper.saveUserData(data)
                    AppCoordinator.shared.changeFlow(navigationFlow: .tabBar(selectedIndex: .main))
                }
                    
                
            }catch {
                self.showErrorToast(with: error.localizedDescription)
            }
            AppIndicator.shared.dismiss()

        }
    }
  
}
