//
//  SceneDelegate.swift
//
//  Created by Ahmed Raslan®
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: AppCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            mainCoordinator = AppCoordinator(window: window!)
            mainCoordinator?.start()
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        Theme.current.style = .light
    }
    
    


}
