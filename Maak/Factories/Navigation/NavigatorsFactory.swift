//
//  NavigatorsFactory.swift
//  Maak
//
//  Created by AAIT on 14/01/2024.
//

 
import UIKit


final class NavigationControllersFactory {
    
    static func makeBaseNav(rootVC: UIViewController)-> BaseNav{
        let baseNav =  BaseNav(rootViewController: rootVC)
        return baseNav
    }
    
    static func makeOrdersNav(rootVC: UIViewController)-> OrdersNavigationController{
        let ordersNavigationController =  OrdersNavigationController(rootViewController: rootVC)
        return ordersNavigationController
    }
    
    
}




final class NavigatorsFactory {
    
    static func makeAuthNavigator()-> AuthNavigator{
        let authNavigator = AuthNavigator(navigationController: NavigationControllersFactory.makeBaseNav(rootVC: AuthFactory.makeLoginVC()))
        return authNavigator
    }
    
    
    static func makeMainNavigator()-> MainNavigator{
        let mainNavigator = MainNavigator(navigationController: NavigationControllersFactory.makeBaseNav(rootVC: MainFactory.makeHomeVC()))
        return mainNavigator
    }
    
 
    
    
    static func makeMoreNavigator()-> MoreNavigator{
        let moreNavigator = MoreNavigator(navigationController: NavigationControllersFactory.makeBaseNav(rootVC: MoreFactory.makeMoreVC()))
        return moreNavigator
    }
}



class OrdersNavigationController: BaseNav {}
