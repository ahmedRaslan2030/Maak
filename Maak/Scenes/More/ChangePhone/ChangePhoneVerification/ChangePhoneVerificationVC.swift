//
//  ChangePhoneVerificationVC.swift
//  Maak
//
//  Created by AAIT on 14/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class ChangePhoneVerificationVC: BaseVC {
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
    private var password: String
  
    
    // MARK: - Init -

    init(phone: String, countryCode: String, password: String) {
        self.phone = phone
        self.countryCode = countryCode
        self.password = password
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
        view.backgroundColor = .clear
        descText.text = "Please enter the code that had been sent to you".localized
    }
    
    private func codeOTPConfigure() {
        codeTextField.configure()
        codeTextField.becomeFirstResponder()
        
        codeTextField.didEnterLastDigit = { [weak self] code in
            guard let self = self else { return }
            self.code = code
            self.codeTextField.resignFirstResponder()
            changePhoneCheckCode(code: code, countryCode: countryCode, phone: phone)
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
        do {
            
            let code = try ValidationService.validate(verificationCode: code)
            
            changePhoneCheckCode(code: code, countryCode: countryCode, phone: phone)
            
        }catch {
            showErrorToast(with: error.localizedDescription)
        }

    }
    
    @IBAction private func resendButtonPressed() {
        changePhoneResendCode(countryCode: countryCode , phone: phone, password: password)
    }

}


// MARK: - FinishPopUpAnimationProtocol -
extension ChangePhoneVerificationVC: FinishPopUpAnimationProtocol {
    func didFinish() {
        AppCoordinator.shared.moreNavigator?.navigate(destination: .more, mode: .popToRoot)
    }
    
}

// MARK: - Networking -
extension ChangePhoneVerificationVC {
    
    private func changePhoneCheckCode(code: String, countryCode: String, phone: String){
        AppIndicator.shared.show(isGif: false)
        Task{
            
            do {
                let response = try await MoreServices.changePhoneCheckCode(countryCode: countryCode, phone: phone, code: code).send(dataType: String.self)
                self.showSuccessToast(with: response.message)
                
                
                self.dismiss(animated: true)
                
                AppCoordinator.shared.moreNavigator?.navigate(destination: .appPopUp(useCase: .changePassWordSuccess, delegate: self, animated: true), mode: .present, modalPresentationStyle: .custom, modalTransitionStyle: .crossDissolve)
                
            } catch {
                showErrorToast(with: error.localizedDescription)

            }
        }
        AppIndicator.shared.dismiss()
    }
    
    
    private func  changePhoneResendCode(countryCode: String, phone: String, password: String){
        AppIndicator.shared.show(isGif: false)
        Task{
            let response = try await MoreServices.changePhoneResendCode(countryCode: countryCode, phone: phone, password: password).send(dataType: String.self)
            startOTPTimer()
            self.showSuccessToast(with: response.message)
         
        }
        AppIndicator.shared.dismiss()
    }
}
