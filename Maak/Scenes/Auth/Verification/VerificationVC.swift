//
//  ActivationVC.swift
//  Maak
//
//  Created by AAIT on 02/01/2024.
//

import UIKit

final class VerificationVC: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet weak private (set) var codeTextField: OTPTextField!
    @IBOutlet weak private (set) var descText: UILabel!
    @IBOutlet weak private (set) var resendCodeStack: UIStackView!
    @IBOutlet weak private (set) var timerLabel: UILabel!
    @IBOutlet weak private (set) var resendCode: UIButton!
    
    // MARK: - Properties
  
    
    private var totalTime: Int = 60
    private var timer: Timer?
    private var phone: String
    private var countryCode: String
    private var code: String = ""
    private var useCase: VerificationType
    private var password: String?
  
    
    // MARK: - Init -

    init(phone: String, countryCode: String , useCase: VerificationType, password: String?) {
        self.phone = phone
        self.countryCode = countryCode
        self.useCase = useCase
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureInitialDesign()
        self.codeOTPConfigure()
        startOTPTimer()
     }

   
    
    
    // MARK: - Design Methods -
    private func configureInitialDesign() {
        switch self.useCase {
            
        case .activation:
            title = "Verification Code".localized
            descText.text = "Please enter the code sent to you via the mobile number to activate your account".localized
            
         case .forgetPassword:
            title = "Reset password".localized
            descText.text = "Please enter the code that had been sent to you".localized
            
      
          
        }
    }
    
    private func codeOTPConfigure() {
        codeTextField.configure()
        codeTextField.becomeFirstResponder()
        
        codeTextField.didEnterLastDigit = { [weak self] code in
            guard let self = self else { return }
            self.code = code
            self.codeTextField.resignFirstResponder()
            switch self.useCase {
            case .activation:
                activateAccount(code: code, countryCode: countryCode, phone: phone)
            case .forgetPassword:
                forgetPasswordCheckCode(code: code, countryCode: countryCode, phone: phone)
         
            }
        }
    }
    
    private func startOTPTimer() {
        self.totalTime = 60
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
    }
    
    
    // MARK: -Actions -
    @objc func updateTimer(_ sender: AnyObject) {
        if totalTime != 0 {
            self.timerLabel.isHidden = false
            self.resendCodeStack.isHidden = true
            totalTime -= 1
            self.timerLabel.text = "\(String(totalTime)) " + "second".localized
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                self.timerLabel.isHidden = true
                self.resendCodeStack.isHidden = false
            }
        }
    }
    
    
    @IBAction private func confirmWasPressed (_ sender: UIButton){
        switch useCase {
        case .activation:
            activateAccount(code: code, countryCode: countryCode, phone: phone)
        case .forgetPassword:
            forgetPasswordCheckCode(code: code, countryCode: countryCode, phone: phone)
     
        }
    }
    
    @IBAction private func resendButtonPressed() {
      self.resendCode(countryCode: countryCode , phone: phone)
    }

}

// MARK: - Networking -
extension VerificationVC {
    private func activateAccount(code: String, countryCode: String, phone: String) {
        AppIndicator.shared.show(isGif: false)
        Task{
            
            do {
                let  response = try await AuthServices.activate(code: code, countryCode: countryCode, phone: phone).send(dataType: User.self)
                guard let user = response.data else { return }
                AppHelper.saveUserData(user)
                AppCoordinator.shared.changeFlow(navigationFlow: .tabBar(selectedIndex: .main))
                self.showSuccessToast(with: response.message)
                
            }catch {
                showErrorToast(with: error.localizedDescription)
            }
            AppIndicator.shared.dismiss()

        }
    }
    
    private func forgetPasswordCheckCode(code: String, countryCode: String, phone: String){
        
        AppIndicator.shared.show(isGif: false)
        
        Task{
            
            do {
                let response = try await AuthServices.forgetPasswordCheckCode(code: code, countryCode: countryCode, phone: phone).send(dataType: String.self)
                self.showSuccessToast(with: response.message)
                
                AppCoordinator.shared.authNavigator?.navigate(destination: .forgetPassword(phone: phone, countryCode: countryCode, code: code), mode: .push)
            }catch {
                showErrorToast(with: error.localizedDescription)
            }
            AppIndicator.shared.dismiss()

        }
     }
    
    private func resendCode(countryCode: String, phone: String){
        AppIndicator.shared.show(isGif: false)
        
        Task{
            
            do {
                let response  = try await AuthServices.resendCode(countryCode: countryCode, phone: phone).send(dataType: String.self)
                self.showSuccessToast(with: response.message)
                startOTPTimer()
                
            } catch {
                showErrorToast(with: error.localizedDescription)
            }
            AppIndicator.shared.dismiss()

        }
    }
    
    
    
  
}
