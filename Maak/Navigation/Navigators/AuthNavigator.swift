//
//  IntroNavigator.swift
//  Maak
//
//  Created by AAIT on 24/12/2023.
//

import UIKit

final class AuthNavigator: Navigator {
    weak var navigationController: UINavigationController? 
     
    enum Destination {
        case login
        case register
        case verification(phone: String, countryCode: String, useCase: VerificationType)
        case checkPhone
        case forgetPassword(phone: String, countryCode: String, code: String)
        case successVC(useCase: AppPopCases = .changePassWordSuccess, delegate:  FinishPopUpAnimationProtocol, animated: Bool = true)
        case terms
    }

    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    deinit {
        print("IntroNavigator is dismissed")
    }

    func createVC(for destination: Destination) -> UIViewController {
        switch destination {
        case .login:
            return AuthFactory.makeLoginVC()

        case .register:
            return AuthFactory.makeRegisterVC()

        case let .verification(phone, countryCode, useCase):
            return AuthFactory.makeVerificationVC(phone: phone, countryCode: countryCode, useCase: useCase, password: nil)

        case .checkPhone:
            return AuthFactory.makeCheckPhoneNumberVC()

        case let .forgetPassword(phone, countryCode, code):
            return AuthFactory.makeForgetPasswordVC(phone: phone, countryCode: countryCode, code: code)

        case let .successVC(useCase, delegate, animated):
            return SharedFactory.makePopUpVC(useCase: useCase, delegate: delegate, animated: animated)
            
        case .terms:
            return MoreFactory.makeAboutUsVC(useCase: .terms)
        }
    }
}
