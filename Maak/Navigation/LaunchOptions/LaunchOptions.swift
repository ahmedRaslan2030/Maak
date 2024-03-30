//
//  LaunchOptions.swift
//  Artist
//
//  Created by AAIT on 29/08/2023.
//

import Foundation

 

public enum LaunchOptions: CaseIterable {
    
    case main
    case auth
    case onboarding
    
    // MARK: - Public methods
    
    static func configure( isFirstTime: Bool =  UserDefaults.isFirstTime , isLoggedIn: Bool = UserDefaults.isLogin) -> LaunchOptions {
        
        switch (isFirstTime, isLoggedIn) {
        case (false, false): return .auth
        case (true, false): return .onboarding
        case (true, true),(false, true): return .main
        }
    }
}
