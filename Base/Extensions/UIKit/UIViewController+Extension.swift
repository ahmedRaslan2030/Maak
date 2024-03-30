//
//  UIViewController+Extension.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import UIKit

extension UIViewController {
    
    func addBackButtonWith(title: String) {
        let button = UIButton()
        let imageName = Language.isRTL() ? "chevron.right" : "chevron.left"
        button.setImage(UIImage(systemName: imageName), for: .normal)
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor(resource: .mainDarkFont)
        button.isUserInteractionEnabled = false
        let stack = UIStackView.init(arrangedSubviews: [button, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.backButtonPressed))
        stack.addGestureRecognizer(tap)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stack)
    }
    func setLeading(title: String?, color: UIColor = UIColor(resource: .mainDarkFont)) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = color
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    @objc func backButtonPressed() {
        self.pop()
    }
    func changeNavigationBar(alpha: CGFloat) {
        self.navigationController?.navigationBar.subviews.first?.alpha = alpha
    }
}
extension UIViewController {
    func push(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    func pop(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    func popToRoot(animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func presentOverFullScreen(_ vc: UIViewController, animated: Bool = false) {
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: animated)
    }
    func presentFullScreen(_ vc: UIViewController, animated: Bool = true) {
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: animated)
    }
    @objc func dismissOverFullScreen() {
        self.dismiss(animated: false)
    }
}
extension UIViewController {
    func addKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
extension UIViewController {
    var isAuthorised: Bool {
        get {
            return UserDefaults.isLogin
        }
    }
}

extension UIViewController {
    
    func addTitle(image: String = "homeTitleLogo") {
        let customImageView = UIImageView(image: UIImage(named: image))
        customImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = customImageView
    }
    
  
}


 
