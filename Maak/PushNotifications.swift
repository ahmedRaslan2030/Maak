
import UIKit
import Firebase



extension AppDelegate : MessagingDelegate{
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken ?? "No Device token found")")
        UserDefaults.pushNotificationToken = fcmToken ?? "No Token Found"
    }
}


extension AppDelegate : UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
    }
    
    //MARK: - Handle the arrived Notifications
    
    //Use this method to process incoming remote notifications for your app
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    
    // MARK: - Foreground Handle
    
    //when the notification arrives and the app is in foreground
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print("Notification info is: \n\(userInfo)")
        
        
        let orderId = userInfo[AnyHashable(FCMValueKeys.orderId.rawValue)] as? String
        
        //        let roomId  = userInfo[AnyHashable(FCMValueKeys.roomId.rawValue)] as? String
        
        let dic = ["id": orderId]
        
        
        guard let targetValue = userInfo[AnyHashable(FCMValueKeys.type.rawValue)] as? String else {return}
        
        
        switch targetValue {
            
            
            //Admin Notifications
            
        case NotificationType.userDeleted.rawValue,
            NotificationType.unblocked.rawValue,
            NotificationType.adminNotify.rawValue,
            NotificationType.block.rawValue:
            self.blockUser()
            
            
            
            // Orders Notifications
            
            
        case NotificationType.acceptNegotiationRequest.rawValue,
            NotificationType.refuseNegotiationRequest.rawValue,
            NotificationType.assignedProvider.rawValue,
            NotificationType.newPriceOffer.rawValue,
            NotificationType.orderFinished.rawValue,
            NotificationType.statusChanged.rawValue,
            NotificationType.storeInvoice.rawValue:
            
            
            NotificationCenter.default.post(name: .reloadOrderDetails, object: nil, userInfo: dic as [AnyHashable: Any])
            
            
        case NotificationType.newMessage.rawValue:
            
            NotificationCenter.default.post(name: .reloadChat, object: nil, userInfo: dic as [AnyHashable: Any])
            
        default:
            break
        }
        
        if UserDefaults.notificationsSoundOn == true {
            completionHandler([.banner,.sound, .list])
        }else {
            completionHandler([.banner , .list])
        }
    }
    
    
    
    
    // MARK: -  Notifications Tap Interactions
    // when the user tap on the notification banner
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
        let userInfo = response.notification.request.content.userInfo
        
        let orderId = userInfo[AnyHashable(FCMValueKeys.orderId.rawValue)] as? String
        let roomId = userInfo[AnyHashable(FCMValueKeys.roomId.rawValue)] as? String
        let receiverId = userInfo[AnyHashable(FCMValueKeys.sender.rawValue)] as? String
        let receiverName = userInfo[AnyHashable(FCMValueKeys.receiverName.rawValue)] as? String
        
        let receiverImage = userInfo[AnyHashable(FCMValueKeys.receiverImage.rawValue)] as? String
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard let window = window else {return}
        guard let root = window.rootViewController as? AppTabBarController else { return }
        let home = root.viewControllers?[0] as! BaseNav
        root.selectedIndex = 0
        root.navigationController?.popToRootViewController(animated: true)
        let currentVC = home.visibleViewController
        let dic = ["id": orderId]
        
        let targetValue = userInfo[AnyHashable(FCMValueKeys.type.rawValue)] as? String
        
        
        switch targetValue {
            
            
            // Chat Notifications
            
        case NotificationType.newMessage.rawValue:
            
            guard let orderId = orderId  else{return}
            
//            AppCoordinator.shared.changeFlow(navigationFlow: .tabBar(selectedIndex: .orders)) {_ in
//                AppCoordinator.shared.ordersNavigator?.navigate(destination: .orderDetails(orderId: orderId.toInt()), mode: .push, completion: {
//                    AppCoordinator.shared.ordersNavigator?.navigate(destination: .chat(roomId: roomId?.toInt() ?? 0, orderId: orderId.toInt(), receiverId: receiverId?.toInt() ?? 0, receiverName: receiverName ?? "", receiverImage: receiverImage ?? "", providerId: receiverId?.toInt() ?? 0, providerRate: "0.0"), mode: .push)
//                })
//            }
            
            
            
            // Orders Notifications
            
//            
//        case NotificationType.acceptNegotiationRequest.rawValue,
//            NotificationType.refuseNegotiationRequest.rawValue,
//            NotificationType.assignedProvider.rawValue,
//            NotificationType.newPriceOffer.rawValue,
//            NotificationType.orderFinished.rawValue,
//            NotificationType.statusChanged.rawValue,
//            NotificationType.storeInvoice.rawValue:
//            
//            
//            guard let orderId = orderId  else{return}
//            
//            AppCoordinator.shared.changeFlow(navigationFlow: .tabBar(selectedIndex: .orders)) {_ in
//                AppCoordinator.shared.ordersNavigator?.navigate(destination: .orderDetails(orderId: orderId.toInt()), mode: .push)
//            }
            
            
        default:
            break
        }
        
    }
    
    
    
    
    
    private func blockUser() {
        UserDefaults.isLogin = false
        UserDefaults.accessToken = nil
        UserDefaults.user = nil
        AppCoordinator.shared.changeFlow(navigationFlow: .auth)
    }
    
}
