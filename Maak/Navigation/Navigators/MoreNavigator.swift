//
//  OrdersNavigator.swift
//  Maak
//
//  Created by AAIT on 11/02/2024.
//

import UIKit

final class MoreNavigator: Navigator {
    weak var navigationController: UINavigationController?

    enum Destination {
        case more
        case notifications
        case editProfileVC
        case changePhoneVC
        case verification(phone: String, countryCode: String,password: String)
        case changePassword
        case languageVC
        case generalSettings
        case aboutUs
        case faqs
        case complaints
        case addComplaint
        case contactUs
        case morePopUpVC(useCase: MorePopUpCases)
        case appPopUp(useCase: AppPopCases, delegate:  FinishPopUpAnimationProtocol, animated: Bool)
    }

    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        navigationController?.navigationBar.backgroundColor = .white
    }

    deinit {
        print("IntroNavigator is dismissed")
    }

    func createVC(for destination: Destination) -> UIViewController {
        switch destination {
        case .more:
            return MoreFactory.makeMoreVC()
        case .notifications:
            return MainFactory.makeNotificationsVC()
        case .editProfileVC:
            return MoreFactory.makeEditProfileVC()
        case .changePhoneVC:
            return MoreFactory.makeChangePhoneVC()
        case let .verification(phone, countryCode, password):
            return MoreFactory.makeChangePhoneVerificationVC(phone: phone, countryCode: countryCode, password: password)
        case .changePassword:
            return MoreFactory.makeChangePasswordVC()
        case .generalSettings:
            return MoreFactory.makeGeneralSettingsVC()
        case .aboutUs:
            return MoreFactory.makeAboutUsVC(useCase: .aboutUs)
        case .faqs:
            return MoreFactory.makeFaqsVC()
        case .complaints:
            return MoreFactory.makeComplaintsVC()
        case .addComplaint:
            return MoreFactory.makeAddComplaintVC()
        case .contactUs:
            return MoreFactory.makeContactUsVC()
        case let .morePopUpVC(useCase):
            return MoreFactory.makeMorePopUpVC(useCase: useCase)
        case .languageVC:
            return IntroFactory.makeAppLanguage(isFromMore: true)
        case let .appPopUp(useCase, delegate, animated):
            return SharedFactory.makePopUpVC(useCase: useCase, delegate: delegate, animated: animated)
       
        }
    }
}
