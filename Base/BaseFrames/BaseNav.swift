//
//  BaseNav.swift
//  Maak
//
//  Created by AAIT on 12/12/2023.
//
import UIKit

class BaseNav: UINavigationController {
    
    //MARK: - Properties -
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    var appearanceBackgroundColor: UIColor { UIColor(resource: .mainBackground) }
    var appearanceTintColor: UIColor { UIColor(resource: .mainDarkFont) }
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGesture()
        self.handleAppearance()
    }
    
    //MARK: - Design -
    private func handleAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: appearanceTintColor, .font: UIFont.systemFont(ofSize: 18)]
        self.navigationBar.tintColor = appearanceTintColor
        appearance.backgroundColor = appearanceBackgroundColor
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupGesture() {
        interactivePopGestureRecognizer?.delegate = self
        self.view.semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    }
    
}
extension BaseNav: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        self.viewControllers.count > 1
    }
}


extension UINavigationController {
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}
