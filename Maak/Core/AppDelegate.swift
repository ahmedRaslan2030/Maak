//
//  AppDelegate.swift
//
//  Created by Ahmed Raslan®
//

import UIKit
import Firebase
import GoogleMaps
import IQKeyboardManager
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Properties -
    let gcmMessageIDKey = "gcm.message_id"
    let googleMapKey = "AIzaSyAoZ356P2Ke2Xm_njlJIiYjrgp3NgEkVnI"
    
    //MARK: - Initializer -
    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
    
    
    //MARK: - App LifeCycle -
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
 
        //MARK: - Font -
        Theme.current.setupFont()
        
        //MARK: - Localization
        Bundle.swizzleLocalization()
        
        //MARK: - Keyboard -
        self.handleKeyboard()
        
        //MARK: - Google Map Key -
        self.handleGoogleMap()
        
        //MARK: - FCM -
        self.setupFCM(application)
        
        return true
    }
    
    
}

extension AppDelegate {

    //MARK: - FCM -
    
    private func setupFCM(_ application: UIApplication){
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            print("paths: \(path.gateways)")
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.setupFirebase(application)
                    queue.suspend()
                }
            } else {
                print("No network connection")
            }
        }
         
    }
    
    private func setupFirebase(_ application: UIApplication) {
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
    
    //MARK: - Keyboard -
    private func handleKeyboard() {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().toolbarTintColor = UIColor(resource: .main)
        let disabledVCs: [UIViewController.Type] = []
        IQKeyboardManager.shared().disabledDistanceHandlingClasses.addObjects(from: disabledVCs)
    }
    
    //MARK: - Google Maps -
    private func handleGoogleMap() {
        GMSServices.provideAPIKey(self.googleMapKey)
    }
    
 
}
