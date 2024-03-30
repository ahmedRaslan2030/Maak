//
//  MoreItemEnum.swift
//  Maak
//
//  Created by AAIT on 12/02/2024.
//

import Foundation



enum MoreItemEnum: CaseIterable{
 
    case editProfile
    case changePhoneNumber
    case changePassword
    case language
    case generalSettings
    case aboutUs
    case complaints
    case faqs
    case contactUs
    case deleteAccount
    case signOut
}


extension MoreItemEnum {
    
    var title: String {
        switch self{
            
        case .editProfile:
            "Profile".localized
        case .changePhoneNumber:
            "Change phone number".localized

        case .changePassword:
            "Change password".localized

        case .language:
            "Language".localized

        case .generalSettings:
            "General Settings".localized

        case .aboutUs:
            "About us".localized

        case .complaints:
            "Complaints and Suggestions".localized

        case .faqs:
            "FAQ".localized

        case .contactUs:
            "Contact us".localized

        case .deleteAccount:
            "Delete Account".localized

        case .signOut:
            "SignOut".localized

        }
    }
    
    
    var image: String {
        switch self {
        case .editProfile:
            "editProfile"
        case .changePhoneNumber:
            "changePhoneNumber"
        case .changePassword:
            "changePassword"
        case .language:
            "language"
        case .generalSettings:
            "generalSettings"
        case .aboutUs:
            "aboutUs"
        case .complaints:
            "complaints"
        case .faqs:
            "faqs"
        case .contactUs:
            "contactUs"
        case .deleteAccount:
            "deleteAccount"
        case .signOut:
            "signOut"
        }
    }
    
}


extension MoreItemEnum {
    var action: () -> () {
        
        let action: () -> () = {
            
            switch self {
            case .editProfile:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .editProfileVC,mode: .push)
            case .changePhoneNumber:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .changePhoneVC,mode: .push)
            case .changePassword:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .changePassword,mode: .push)
            case .language:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .languageVC,mode: .push)
            case .generalSettings:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .generalSettings,mode: .push)
            case .aboutUs:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .aboutUs,mode: .push)
            case .complaints:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .complaints ,mode: .push)
            case .faqs:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .faqs,mode: .push)
            case .contactUs:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .contactUs,mode: .push)
                
            case .deleteAccount:
                  AppCoordinator.shared.moreNavigator?.navigate(destination: .morePopUpVC(useCase: .deleteAccount), mode: .present, modalPresentationStyle: .custom, modalTransitionStyle: .crossDissolve)
                
            case .signOut:
                  AppCoordinator.shared.moreNavigator?.navigate(destination: .morePopUpVC(useCase: .signOut), mode: .present, modalPresentationStyle: .custom, modalTransitionStyle: .crossDissolve)
            }
        }
        
        return action
    }
}


enum MoreVisitorItemEnum: CaseIterable{
 
    case editProfile
    case changePhoneNumber
    case changePassword
    case language
    case generalSettings
    case aboutUs
    case complaints
    case faqs
    case contactUs
}


extension MoreVisitorItemEnum {
    
    var title: String {
        switch self{
            
        case .editProfile:
            "Profile".localized
        case .changePhoneNumber:
            "Change phone number".localized

        case .changePassword:
            "Change password".localized

        case .language:
            "Language".localized

        case .generalSettings:
            "General Settings".localized

        case .aboutUs:
            "About us".localized

        case .complaints:
            "Complaints and Suggestions".localized

        case .faqs:
            "FAQ".localized

        case .contactUs:
            "Contact us".localized

        }
    }
    
    
    var image: String {
        switch self {
        case .editProfile:
            "editProfile"
        case .changePhoneNumber:
            "changePhoneNumber"
        case .changePassword:
            "changePassword"
        case .language:
            "language"
        case .generalSettings:
            "generalSettings"
        case .aboutUs:
            "aboutUs"
        case .complaints:
            "complaints"
        case .faqs:
            "faqs"
        case .contactUs:
            "contactUs"
        }
    }
    
}


extension MoreVisitorItemEnum {
    var action: () -> () {
        
        let action: () -> () = {
            
            switch self {
            case .language:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .languageVC,mode: .push)
                
       
            case .aboutUs:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .aboutUs,mode: .push)
           
            case .faqs:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .faqs,mode: .push)
            case .contactUs:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .contactUs,mode: .push)
                
            case .editProfile, .changePhoneNumber, .changePassword, .generalSettings, .complaints:
                AppCoordinator.shared.moreNavigator?.navigate(destination: .morePopUpVC(useCase: .visitor), mode: .present, modalPresentationStyle: .custom, modalTransitionStyle: .crossDissolve)
                
                
            }
        }
        
        return action
    }
}
