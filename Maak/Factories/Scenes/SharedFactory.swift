//
//  SharedFactory.swift
//  Maak
//
//  Created by AAIT on 14/01/2024.
//

import Foundation

final class SharedFactory {
    
    static func makePopUpVC(useCase: AppPopCases , delegate: FinishPopUpAnimationProtocol, animated: Bool)-> AppPopupVC{
        
        let popUpVC = AppPopupVC(useCase: useCase, delegate: delegate, animated: animated)
        return popUpVC
    }
    
    static func makeLocationMapVC(type: ScreenType, location: Location?, delegate: LocationMapDelegate)-> LocationMapVC{
        
      let locationMapVC = LocationMapVC(type: type, location: location, delegate: delegate)
        
     return locationMapVC
    }
    
    
    static func makeLoginPopUpVC()-> LoginPopUpVC{
        let loginPopUp = LoginPopUpVC(animationName: AppPopCases.visitor.animationName, message: AppPopCases.visitor.message)
        loginPopUp.modalPresentationStyle = .custom
        loginPopUp.modalTransitionStyle = .crossDissolve
        return loginPopUp
    }
    
}

 
