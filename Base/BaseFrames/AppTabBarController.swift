//
//  AppTabBarController.swift
//  WithYou
//
//  Created by Ahmed Raslan on 01/09/2023.
//

import UIKit

class AppTabBarController: UITabBarController {

    
    
    private let topLine: UIView = {
           let view = UIView()
        view.backgroundColor = UIColor(resource: .secondary)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
       }()
    private var leadingConstraint = NSLayoutConstraint()
    private var widthConstraint = NSLayoutConstraint()
   

    
    
    //MARK: - Properties -
    init(controllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = controllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.customTabBarDesign()
     }
    
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item == tabBar.items?[1] &&  UserDefaults.isLogin != true   {
             
            self.present(SharedFactory.makeLoginPopUpVC(), animated: true)

        }  else {
            /// To Animate tabBar indicatorView
            if let itemIndex = tabBar.items?.firstIndex(of: item), let itemsCount = tabBar.items?.count  {
                
                let index = CGFloat(integerLiteral: itemIndex)
                let tabBarWidth = tabBar.frame.width
                let tabBarItemSize = CGSize(width: tabBarWidth / CGFloat(itemsCount), height: tabBar.frame.height)
                
                self.setupTopLineWidth(width: tabBarItemSize.width)
                self.setupTopLineLeading(constant: index * tabBarItemSize.width)
                
                
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.view.layoutIfNeeded()
                }
                
            }
            
            /// To Animate tabBar item
            guard let barItemView = item.value(forKey: "view") as? UIView else { return }
            
            let timeInterval: TimeInterval = 0.4
            let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
                barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
            }
            propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
            propertyAnimator.startAnimation()
        }
    }
    
    //MARK: - Design -
    private func customTabBarDesign() {
        
        let tabBarAppearance = UITabBarItem.appearance()
        UITabBar.appearance().tintColor = UIColor(resource: .secondary)
        self.tabBar.backgroundColor = .white
        let attribute = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 10)]
        tabBarAppearance.setBadgeTextAttributes(attribute as [NSAttributedString.Key : Any], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attribute as [NSAttributedString.Key : Any], for: .normal)

        let tabFont =  UIFont.systemFont(ofSize: 10)
        
        let appearance = UITabBarAppearance()
        
        appearance.backgroundColor = .white
        
        let selectedAttributes: [NSAttributedString.Key: Any]
        = [NSAttributedString.Key.font: tabFont]
        
        let normalAttributes: [NSAttributedString.Key: Any]
        = [NSAttributedString.Key.font: tabFont, NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = normalAttributes
        
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = normalAttributes
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance

    }
    
    
    private func addSelectionStyle(){
        
       
    }
 
}



extension AppTabBarController {
    
    private func setupTopLine() {
           guard let itemsCount = tabBar.items?.count else { return }
           tabBar.addSubview(topLine)
           topLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
           let tabBarWidth = tabBar.frame.width
           let tabBarItemSize = CGSize(width: tabBarWidth / CGFloat(itemsCount), height: tabBar.frame.height)
           setupTopLineWidth(width: tabBarItemSize.width)
           setupTopLineLeading(constant: CGFloat(selectedIndex) * tabBarItemSize.width)
       }
       
       private func setupTopLineWidth(width: CGFloat) {
           widthConstraint.isActive = false
           widthConstraint = NSLayoutConstraint(item: topLine, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: width)
           widthConstraint.isActive = true
       }
       
       private func setupTopLineLeading(constant: CGFloat) {
           leadingConstraint.isActive = false
           leadingConstraint = NSLayoutConstraint(item: topLine, attribute: .leading, relatedBy: .equal, toItem: tabBar, attribute: .leading, multiplier: 1, constant: constant)
           leadingConstraint.isActive = true
       }
    
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated) 
        setupTopLine()
    }
       

}




extension AppTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let _ = viewControllers else { return false }
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        guard fromView != toView else {
            return false
        } 
        
        if  viewController.isKind(of: OrdersNavigationController.self) && (UserDefaults.isLogin != true){
                self.present(SharedFactory.makeLoginPopUpVC(), animated: true)
                return false
        }else{
            
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
            return true
        }
        
     
    }
}

private extension UIView {
    func pinToSuperWith(padding: CGFloat) {
        guard let superview = superview else {return}
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding).isActive = true
    }
}


