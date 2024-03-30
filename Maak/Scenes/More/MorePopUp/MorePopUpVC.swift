//
//  MorePopUpVC.swift
//  Maak
//
//  Created by AAIT on 12/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit
import Lottie

 

final class MorePopUpVC: BaseVC {
    
    // MARK: - IBOutlets -
    @IBOutlet private var animationView: LottieAnimationView!
    @IBOutlet private var messageLabel: UILabel!
    
    // MARK: - Properties -
    
    private var animationName: String
    private var message: String
    private var useCase: MorePopUpCases
 
    // MARK: - Init -
    init(useCase: MorePopUpCases){
        self.animationName = useCase.animationName
        self.message = useCase.message
        self.useCase = useCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialDesign()
        
        
    }
    
    // MARK: - Design Methods -
    private func configureInitialDesign() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        messageLabel.text = message
        setupAnimation()
        
    }
    
    
    private func setupAnimation(){
        animationView.animation = LottieAnimation.named(animationName)
        animationView.loopMode = .playOnce
        animationView.play()
    }
    
 
    
    @IBAction private func confirmAction(_ sender: UIButton){
        switch useCase {
        case .signOut:
            logOutApi()
        case .deleteAccount:
            deleteAccountApi()
        case .visitor:
            AppCoordinator.shared.changeFlow(navigationFlow: .auth)
        }
    }
    
    
    @IBAction private func dismissAction(_ sender: UIButton){
        self.dismiss(animated: true)
        
    }
    
}


extension MorePopUpVC {
    private func logOutApi(){
        AppIndicator.shared.show(isGif: false)
        
        Task {
           
          let _ = try await MoreServices.logOut.send(dataType: String?.self)
            AppHelper.deleteUserDefaults()
            AppCoordinator.shared.changeFlow(navigationFlow: .auth)

        }
        
        AppIndicator.shared.dismiss()

    }
    
    
    private func deleteAccountApi(){
        AppIndicator.shared.show(isGif: false)
        
        Task {
           
          let _ = try await MoreServices.logOut.send(dataType: String?.self)
            AppHelper.deleteUserDefaults()
            AppCoordinator.shared.changeFlow(navigationFlow: .auth)
         }
        
        AppIndicator.shared.dismiss()

    }
    
}
