//
//  SplashVC.swift
//  Maak
//
//  Created by AAIT on 21/12/2023.
//

import AVKit
import UIKit

final class SplashVC: BaseVC {
    // MARK: - Properties -


    // MARK: - Initializers -

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialDesign()
        checkRoute()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
     }

    // MARK: - Design Methods -

    private func configureInitialDesign() {
        view.backgroundColor =  UIColor(resource: .main)
        changeLanguage(lang: UserDefaults.isFirstTime ? "en" : Language.currentLanguage())
    }

    private func changeLanguage(lang: String) {
        Language.setAppLanguage(lang: lang)
    }
}

 


// MARK: -Route -
extension SplashVC {
    
    private func checkRoute(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
            switch LaunchOptions.configure() {
            case .main:
                AppCoordinator.shared.changeFlow(navigationFlow: .tabBar(selectedIndex: .main))
            case .auth:
                AppCoordinator.shared.changeFlow(navigationFlow: .auth)

            case .onboarding:
                AppCoordinator.shared.changeFlow(navigationFlow: .language)
            }
        }
    }
}
