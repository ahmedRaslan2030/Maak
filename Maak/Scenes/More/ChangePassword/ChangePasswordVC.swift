//
//  ChangePasswordVC.swift
//  Maak
//
//  Created by AAIT on 13/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class ChangePasswordVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var oldPasswordTF: AppTextField!
    @IBOutlet weak var newPasswordTF: AppTextField!
    @IBOutlet weak var confirmPasswordTF: AppTextField!
    
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
    }
    
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        self.title = "New Password".localized
        view.backgroundColor = UIColor(resource: .secondaryBackground)
    }
    
    //MARK: - Logic Methods -
    private func validate(){
        do{
            let oldPassword = try ValidationService.validate(oldPassword: oldPasswordTF.textField.text)
            let newPassword = try ValidationService.validate(newPassword: newPasswordTF.textField.text)
            let confirmPassword = try ValidationService.validate(newPassword: newPassword, confirmPassword: confirmPasswordTF.textField.text )
            
            updatePassword(password: confirmPassword, oldPassword: oldPassword)
            
        }catch {
            showErrorToast(with: error.localizedDescription)
        }
    }
  
    
     //MARK: - Actions -
    @IBAction private func saveChangesAction(_ sender: UIButton) {
        validate()
    }
}


//MARK: - FinishPopUpAnimationProtocol -
extension ChangePasswordVC: FinishPopUpAnimationProtocol{
    func didFinish() {
        self.pop()
    }
}

//MARK: - Networking -
extension ChangePasswordVC {
    private func updatePassword(password: String,oldPassword: String){
        AppIndicator.shared.show(isGif: false)
        Task{
            do{
                let _ = try await MoreServices.updatePassword(password: password, oldPassword: oldPassword).send(dataType: User.self)
                AppCoordinator.shared.moreNavigator?.navigate(destination: .appPopUp(useCase: .changePassWordSuccess, delegate: self, animated: true), mode: .present, modalPresentationStyle: .custom , modalTransitionStyle: .crossDissolve)
                
            }catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
    }
}
 
