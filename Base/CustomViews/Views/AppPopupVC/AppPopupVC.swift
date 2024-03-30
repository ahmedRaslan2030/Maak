//
//  SuccessVC.swift
//  Maak
//
//  Created by AAIT on 14/01/2024.
//
//  Template by Ahmed Raslan®

import Lottie
import UIKit

protocol FinishPopUpAnimationProtocol: AnyObject {
    func didFinish()
}

final class AppPopupVC: BaseVC {
    // MARK: - IBOutlets -

    @IBOutlet private var animationView: LottieAnimationView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var messageLabel: UILabel!

    // MARK: - Properties -

    private var animationName: String
    private var message: String
    private weak var delegate: FinishPopUpAnimationProtocol?
    private var animated: Bool = true
    private var isDismissible: Bool
    
    // MARK: - Init -
    init(useCase: AppPopCases, delegate: FinishPopUpAnimationProtocol,animated: Bool = true ){
        self.animationName = useCase.animationName
        self.message = useCase.message
        self.delegate = delegate
        self.animated = animated
        self.isDismissible = useCase.isDismissible
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
        animated  == true ?  setupAnimation() :  setupImageView()

    }
    
    
    private func setupAnimation(){
        animationView.animation = LottieAnimation.named(animationName)
        animationView.loopMode = .playOnce
        
        animationView.play { [weak self] finished in
            if finished {
                self?.dismiss(animated: true)
                self?.delegate?.didFinish()
            }
        }
    }
    
    private func setupImageView() {
        imageView.isHidden = false
        animationView.isHidden = true
        imageView.image = UIImage(named: animationName)
    }
    
    
    @IBAction private func dismissAction(_ sender: UIButton){
        isDismissible == true ? self.dismiss(animated: true) : ()
    }
    
}

 
