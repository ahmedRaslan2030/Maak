//
//  TabBarFactory.swift
//  Maak
//
//  Created by AAIT on 14/01/2024.
//

import UIKit

final class TabBarControllerFactory {
    
    static func makeAppTabBar(controllers: [UIViewController],selectedIndex: TabBarControllerIndex)-> AppTabBarController{
        let appTabBar = AppTabBarController(controllers: controllers)
        appTabBar.selectedIndex = selectedIndex.rawValue
        return appTabBar
    }
    
    
    static func makeAppTabBarControllers()-> [UIViewController]{
        var controllers: [UIViewController] = []
        

        AppCoordinator.shared.mainNavigator = NavigatorsFactory.makeMainNavigator()
        
 
        AppCoordinator.shared.moreNavigator = NavigatorsFactory.makeMoreNavigator()
        
        

        controllers.append(
            makeTabBarTab(
            navigator: AppCoordinator.shared.mainNavigator!,
            title: "Home".localized,
            image: UIImage(resource: .home),
            titntColor: UIColor(resource: .secondary))
        )
        
        
        
        controllers.append(
            makeTabBarTab(
            navigator: AppCoordinator.shared.moreNavigator!,
            title: "More".localized,
            image: UIImage(resource: .more),
            titntColor: UIColor(resource: .secondary))
        )
        
        
        return controllers
    }
    
    
}

extension TabBarControllerFactory {
    
    private static func makeTabBarTab(navigator: any Navigator , title: String ,image: UIImage, titntColor: UIColor, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))-> UIViewController{
 
        navigator.navigationController!.tabBarItem = UITabBarItem(title: title, image:  image.withTintColor(titntColor), tag: 0)
        
        navigator.navigationController!.tabBarItem.imageInsets = insets
        
        return  navigator.navigationController!
    }
}

public enum  TabBarControllerIndex: Int {
    case main = 0
    case orders = 1
    case more = 2
}
