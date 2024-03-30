//
//  AppLanguageVC.swift
//  Maak
//
//  Created by AAIT on 24/12/2023.
//

import UIKit

final class AppLanguageVC: BaseVC {
    // MARK: - IBOutlets -
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var chooseLabel: UILabel!
    @IBOutlet weak var arabicView: UIView!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var arabicBackView: CircleView!
    @IBOutlet weak var englishBackView: CircleView!
    @IBOutlet weak var confirmButton: AppButton!
    @IBOutlet weak var mainStackView: UIStackView!
    
    // MARK: - Properties -
    private var intros: [Intro] = []
    private var isFromMore: Bool = false
    
    
    // MARK: - Init -

    init(isFromMore: Bool) {
        self.isFromMore = isFromMore
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    //MARK: - Actions -
    
    @objc private func arabicViewWasTapped(_ sender: UITapGestureRecognizer) {
        setLangDesign(.arabic)
    }
    
    @objc private func englishViewWasTapped(_ sender: UITapGestureRecognizer) {
        setLangDesign(.english)
    }
    
    @IBAction private func confirmButtonPressed(_ sender: UIButton) {
      isFromMore == false ? AppCoordinator.shared.changeFlow(navigationFlow: .intro(intros: intros))
    :
    AppCoordinator.shared.changeFlow(navigationFlow: .tabBar(selectedIndex: .more) , animationOption: Language.isRTL() ? .transitionFlipFromLeft : .transitionFlipFromRight )
    }
    
}

//MARK: - Configuration -
extension AppLanguageVC {
    
    private func configuration() {
        isFromMore == true ? title = "App Language".localized : ()
        hidesBottomBarWhenPushed = true
        setLangDesign(.arabic)
        configureUI()
    }
    
    private func configureUI() {
        self.arabicView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(arabicViewWasTapped(_:))))
        self.arabicView.addCorner(8.0)
        self.arabicView.layer.borderWidth = 2
        self.englishView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(englishViewWasTapped(_:))))
        self.englishView.addCorner(8.0)
        self.englishView.layer.borderWidth = 2
    }
    
   
}

//MARK: - Logic Methods -

extension AppLanguageVC {
    
    private func setLangDesign(_ lang: AppLanguage) {
        
        titleLabel.isHidden = isFromMore
        
      
        Language.setAppLanguage(lang: lang.rawValue)
       
        arabicView.backgroundColor = lang == .arabic ? UIColor(resource: .secondary).withAlphaComponent(0.1) : .white
        
        englishView.backgroundColor = lang == .english ?  UIColor(resource: .secondary).withAlphaComponent(0.1) : .white
        
        arabicView.layer.borderColor = lang == .arabic ?  UIColor(resource: .activeBorder).cgColor :  UIColor(resource: .inactiveBorder).cgColor
        
        englishView.layer.borderColor = lang == .english ? UIColor(resource: .activeBorder).cgColor  : UIColor(resource: .inactiveBorder).cgColor
        
        arabicBackView.backgroundColor = lang == .arabic ? .white : UIColor(resource: .mainBackground)
        
        englishBackView.backgroundColor = lang == .english ? .white: UIColor(resource: .mainBackground)
        
        mainStackView.alignment = lang == .english ? .trailing : .leading
        
        titleLabel.text = lang == .english ? "App Language" : "لغة التطبيق"
        
        welcomeLabel.text = lang == .english ? "Welcome" : "مرحباً"
        
        chooseLabel.text = lang == .english ? "Please choose app language" : "من فضلك قم بتحديد لغة التطبيق"
        
        confirmButton.setTitle(lang == .english ? "Confirm" : "تأكيد" , for: .normal)
    }
}

// MARK: - Networking -

extension AppLanguageVC {
   
}
 
