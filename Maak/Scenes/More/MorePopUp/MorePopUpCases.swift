//
//  MorePopUpCase.swift
//  Maak
//
//  Created by AAIT on 12/02/2024.
//

import Foundation

public enum MorePopUpCases {
    case signOut
    case deleteAccount
    case visitor
}


extension MorePopUpCases: PopUpProtocol {
  
    
    var animationName: String {
        switch self {
        case .signOut:
            return AppLottieAnimations.notAvailable.rawValue

        case .deleteAccount:
            return AppLottieAnimations.notAvailable.rawValue
            
        case .visitor:
            return AppLottieAnimations.notAvailable.rawValue
        }
    }
    
    var message: String {
        switch self {
            
        case .signOut:
            "Are you sure you want to log off ?".localized
        case .deleteAccount:
            "Are you sure you want to delete account ?".localized
        case .visitor:
            AppPopCases.visitor.message
        }
    }
    
    var isDismissible: Bool {
        switch self {
        case .signOut:
            return true
        case .deleteAccount:
            return true
        case .visitor:
           return true
        }
    }

}
