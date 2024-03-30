//
//  AppPopupCasee.swift
//  Maak
//
//  Created by AAIT on 23/01/2024.
//

import Foundation


protocol PopUpProtocol {
    var animationName: String { get  }
    var message: String { get  }
    var isDismissible: Bool { get  }
}


public enum AppPopCases {
    case changePassWordSuccess
    case serviceNotAvailable
    case orderCreatedSuccessfully
    case updateProfileData
    case addComplaint
    case paymentSuccess
    case clientRefuseHold
    case visitor
}

extension AppPopCases: PopUpProtocol {
    var animationName: String {
        switch self {
        case .changePassWordSuccess, .orderCreatedSuccessfully, .updateProfileData,.addComplaint, .paymentSuccess:
            return AppLottieAnimations.success.rawValue
        case .serviceNotAvailable, .visitor:
            return AppLottieAnimations.notAvailable.rawValue
        case .clientRefuseHold:
            return AppLottieAnimations.refusal.rawValue
        }
    }

    var message: String {
        switch self {
        case .changePassWordSuccess, .updateProfileData:
          return   "Changes have been saved successfully".localized
        case .serviceNotAvailable:
            return "Coming soon...Stay tuned".localized
        case .orderCreatedSuccessfully:
            return  "Order has been sent successfully,waiting order offers".localized
        case .addComplaint:
            return  "Your complaint has been sent successfully".localized
        case .paymentSuccess:
            return  "Successful payment transaction".localized
            
        case .clientRefuseHold:
            return "Provider request has been declined successfully and it will be on scheduled time".localized
        case .visitor:
            return "You have to sign in first".localized
        }
    }
    
    var isDismissible: Bool {
        switch self {
            
        case .changePassWordSuccess, .serviceNotAvailable, .updateProfileData,.addComplaint , .visitor:
          return   true
  
        case .orderCreatedSuccessfully, .paymentSuccess, .clientRefuseHold:
            return  false
    
       
            
        }
    }
}

public enum AppLottieAnimations: String {
    case success = "success"
    case notAvailable = "sad"
    case magnifying = "magnifying"
    case watch = "watch"
    case refusal = "refusal"
}
