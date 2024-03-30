//
//  NSNotificationNames.swift
//
//  Created by Ahmed Raslan®
//

import Foundation

extension NSNotification.Name {
    
    /*
     Enum for Holding all strings keys as rawValues to avoid using Strings
     */
    private enum Names: String {
        case isLoginChanged
        case reloadChat
        case reloadOrders
        case reloadOrderDetails
    }
    
    
    /*
     All Notification cases
     */
    static let isLoginChanged = Notification.Name(rawValue: Names.isLoginChanged.rawValue)
    
    static let reloadChat = Notification.Name(rawValue: Names.reloadChat.rawValue)
    
    static let reloadOrders = Notification.Name(rawValue: Names.reloadOrders.rawValue)
    
    
    static let reloadOrderDetails = Notification.Name(rawValue: Names.reloadOrderDetails.rawValue)
    
    
    
    
    
}
