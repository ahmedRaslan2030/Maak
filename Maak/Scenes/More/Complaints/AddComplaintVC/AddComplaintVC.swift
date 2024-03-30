//
//  AddComplaintVCVC.swift
//  Maak
//
//  Created by AAIT on 17/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class AddComplaintVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet private weak var complaintTitleTF: AppTextField!
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
    }
    
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        self.title = "Add Complaint".localized
    }
    
 
    //MARK: - Actions -

    @IBAction func sendAction(_ sender: Any) {
          validate()
    }
 
}


//MARK: - FinishPopUpAnimationProtocol -
extension AddComplaintVC: FinishPopUpAnimationProtocol{
    func didFinish() {
        AppCoordinator.shared.changeFlow(navigationFlow: .tabBar(selectedIndex: .more))
     }
}

// MARK: - Validation -
extension AddComplaintVC {
    private func validate() {
        do {
            let title = try ValidationService.validate(title: complaintTitleTF.textField.text)
            
            
            let message = try ValidationService.validate(message: messageTV.textArea.textView.text)
            
            sendComplain(type: ComplaintsTypeEnum.generic.rawValue, title: title, content: message)
            
        } catch {
            self.showErrorToast(with: error.localizedDescription)
        }
    }
}


//MARK: - Networking -
extension AddComplaintVC {
    private func sendComplain(type: String,title: String,  content: String){
             AppIndicator.shared.show(isGif: false)
            Task {
                do {
                    let response  = try await MoreServices.addComplaint(type: type, title: title, content: content).send(dataType: Complaint?.self)
                    self.showSuccessToast(with: response.message)
                    
                    AppCoordinator.shared.moreNavigator?.navigate(destination: .appPopUp(useCase: .changePassWordSuccess, delegate: self, animated: true), mode: .present, modalPresentationStyle: .custom , modalTransitionStyle: .crossDissolve)
                    
                } catch {
                    self.showErrorToast(with: error.localizedDescription)
                }
            }
            AppIndicator.shared.dismiss()
        }
    }

 
