//
//  MainNavigator.swift
//  Maak
//
//  Created by AAIT on 20/01/2024.
//


import UIKit

final class MainNavigator: Navigator {
    weak var navigationController: UINavigationController?
    
     
    enum Destination {
        case homeVC
        
 
        case popUp(useCase: AppPopCases , delegate: FinishPopUpAnimationProtocol, animated: Bool)
 
        
        case locationMap(type: ScreenType, location: Location?, delegate: LocationMapDelegate)
    
    }

    required init(navigationController: UINavigationController?) {

        self.navigationController = navigationController
        navigationController?.navigationBar.backgroundColor = .white

    }

    deinit {
        print("IntroNavigator is dismissed")
    }

    func createVC(for destination: Destination) -> UIViewController {
        switch destination {
        case .homeVC:
            return MainFactory.makeHomeVC()
            
 
            
     
           
        case let .popUp(useCase, delegate,animated):
            return SharedFactory.makePopUpVC(useCase: useCase, delegate: delegate, animated: animated)
            
   
            
        case let .locationMap(type, location, delegate):
            return SharedFactory.makeLocationMapVC(type: type, location: location, delegate: delegate)
            
   
        }
    }
}
