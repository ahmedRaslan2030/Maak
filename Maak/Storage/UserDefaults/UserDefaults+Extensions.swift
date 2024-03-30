//
//  UserDefaults+Extensions.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import Foundation

extension UserDefaults {
    
    private enum Keys: String {
        case isLogin
        case isFirstTime
        case enableOnboarding
        case user
        case accessToken
        case pushNotificationToken
        case isNotify
        case notificationsSoundOn
        case countryCodes
        case notificationCount
        case themeStyle
    }
    
    
    
    @ModelsDefault(key: Keys.accessToken.rawValue, defaultValue: nil)
    static var accessToken: String?
    
    @ValueDefault(key: Keys.isLogin.rawValue, defaultValue: false)
    static var isLogin: Bool {
        didSet {
            NotificationCenter.default.post(name: .isLoginChanged, object: nil)
        }
    }
    
    @ModelsDefault(key: Keys.isFirstTime.rawValue, defaultValue: true)
    static var isFirstTime: Bool
    

    
    @ModelsDefault(key: Keys.themeStyle.rawValue, defaultValue: .systemStyle)
    static var themeStyle: Theme.Style
    
    @ValueDefault(key: Keys.enableOnboarding.rawValue, defaultValue: true)
    static var enableOnboarding: Bool
    
    
    @ModelsDefault(key: Keys.user.rawValue, defaultValue: nil)
    static var user: User?


    @ModelsDefault(key: Keys.isNotify.rawValue, defaultValue: true)
    static var isNotify: Bool
 
    @ModelsDefault(key: Keys.notificationsSoundOn.rawValue, defaultValue: true)
    static var notificationsSoundOn: Bool
    
    @ModelsDefault(key: Keys.pushNotificationToken.rawValue, defaultValue: nil)
    static var pushNotificationToken: String?
    
    
    @ModelsDefault(key: Keys.notificationCount.rawValue, defaultValue: 0)
    static var notificationCount: Int
}



