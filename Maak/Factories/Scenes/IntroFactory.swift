//
//  IntroFactory.swift
//  Maak
//
//  Created by AAIT on 24/12/2023.
//

import Foundation

final class IntroFactory {
    
    static func makeSplashVC()-> SplashVC {
        let splashVC = SplashVC()
        return splashVC
    }
    
    
    static func makeIntroPageController(intros: [Intro]) -> IntroPageController {
        let pageController =  IntroPageController(intros: intros)
        return pageController
    }
    
    
    static func makeIntroVC(image: String?, title: String?, body: String?, tag: Int)-> IntroVC{
        let introVC = IntroVC(image: image, title: title, body: body, tag: tag)
        return introVC
    }
    
    
    static func makeAppLanguage(isFromMore: Bool)-> AppLanguageVC{
        let appLanguage = AppLanguageVC(isFromMore: isFromMore)
        appLanguage.hidesBottomBarWhenPushed = isFromMore
        return appLanguage
    }
}
