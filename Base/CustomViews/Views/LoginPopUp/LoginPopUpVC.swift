//
//  LoginPopUpVC.swift
//  Maak
//
//  Created by AAIT on 24/03/2024.
//
//  Template by Ahmed Raslan®


import UIKit
import Lottie

final class LoginPopUpVC: BaseVC {
    
    // MARK: - IBOutlets -
    @IBOutlet private var animationView: LottieAnimationView!
    @IBOutlet private var messageLabel: UILabel!
    
    //MARK: - Properties -
    private var animationName: String
    private var message: String

    
    //MARK: - Init -
 
    init(animationName: String,  message: String) {
        self.animationName = animationName
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialDesign()
    }
    
    
    // MARK: - Design Methods -
    private func configureInitialDesign() {
        messageLabel.text = message
        view.backgroundColor = .black.withAlphaComponent(0.2)
        setupAnimation()
        
    }
    
    
    private func setupAnimation(){
        animationView.animation = LottieAnimation.named(animationName)
        animationView.loopMode = .playOnce
        animationView.play()
    }
    
 
    
    //MARK: - Actions -
    @IBAction private func gotToLogin(){
        AppCoordinator.shared.changeFlow(navigationFlow: .auth)
    }
    
    @IBAction private func cancelAction(){
        self.dismiss(animated: true)
    }
    
    
}


 
