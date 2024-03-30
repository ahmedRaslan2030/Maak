//
//  AppCoordinator.swift
//  Artist
//
//  Created by AAIT on 25/08/2023.
//

import UIKit


// MARK: - Coordinator Protocol

 protocol Coordinator: AnyObject {
     func start()
     func changeRoot(rootVC: UIViewController, animationOption: UIView.AnimationOptions, animations: (() -> Void)? , completion: ((Bool) -> Void)? )
 }

 
// MARK: - AppCoordinator

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties -
    
  static let shared: AppCoordinator = AppCoordinator()
    
    
  private var window : UIWindow
    


  
  public enum NavigationFlow {
      case language
      case intro(intros: [Intro])
      case auth
      case tabBar(selectedIndex: TabBarControllerIndex)
    }
    
    
    var authNavigator: AuthNavigator?
  
    
    var mainNavigator: MainNavigator?
    
 
    var moreNavigator: MoreNavigator?

    
 
    // MARK: - init -

    init(window: UIWindow = UIWindow()) {
        self.window = window
    }

    
    // MARK: - Methods -

     func start() {
         window.rootViewController =  IntroFactory.makeSplashVC()
         window.makeKeyAndVisible()
    }

    
    
    func changeRoot(rootVC: UIViewController, animationOption: UIView.AnimationOptions = .transitionCrossDissolve , animations: (() -> Void)? = nil , completion: ((Bool) -> Void)? = nil ) {
        UIApplication.shared.windows.first?.rootViewController = rootVC
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard let window = window else {return}
        UIView.transition(with: window, duration: 0.3, options: animationOption, animations: animations, completion: completion)
    }
    
    
    
    
    
    func changeFlow(navigationFlow: NavigationFlow,  animationOption: UIView.AnimationOptions = .transitionCrossDissolve,  completion: ((Bool) -> Void)? = nil) {
        switch navigationFlow {

        case .language:
            changeRoot(rootVC:  IntroFactory.makeAppLanguage(isFromMore: false))
 
        case let .intro(intros):
            changeRoot(rootVC: IntroFactory.makeIntroPageController(intros: intros))
            
    
            
        case  .auth:
            self.authNavigator = NavigatorsFactory.makeAuthNavigator()
            
            changeRoot(rootVC: (authNavigator?.navigationController)!, animationOption: animationOption, completion: completion)
            
        case let .tabBar(selectedIndex):
            changeRoot(rootVC: TabBarControllerFactory.makeAppTabBar(controllers: TabBarControllerFactory.makeAppTabBarControllers(), selectedIndex: selectedIndex))
        }
    }
   
    
}



