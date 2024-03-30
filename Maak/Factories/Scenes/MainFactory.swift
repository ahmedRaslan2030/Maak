//
//  MainFactory.swift
//  Maak
//
//  Created by AAIT on 14/01/2024.
//

import Foundation

final class MainFactory {
    
    static func makeHomeVC()-> HomeVC {
        let homeVC = HomeVC()
        return homeVC
    }
    
   
    
    static func makeNotificationsVC()-> NotificationsVC {
        let notificationsVC = NotificationsVC()
        notificationsVC.hidesBottomBarWhenPushed = true
        return notificationsVC
    }
    
    
}
