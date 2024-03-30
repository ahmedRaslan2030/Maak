//
//  ToastManager.swift
//  MVVM-Base
//
//  Created by MGA on 01/07/2023.

///  This is inspired by My old Alert and `Ahmed masoud`'s ToastManager project

import UIKit

class ToastManager {
    
    //MARK: - Types -
    struct Theme {
        let textColor: UIColor
        let backgroundColor: UIColor
    }
    struct Components {
        let title: String?
        let body: String?
        let image: UIImage?
    }
    enum Message {
        
        case success(text: String?)
        case error(text: String?)
        case warning(text: String?)
        case custom(theme: Theme, components: Components)
        
        
        var textColor: UIColor {
            switch self {
            case .success:
                return .white
            case .error:
                return .white
            case .warning:
                return .black
            case .custom(let theme, _):
                return theme.textColor
            }
        }
        var backgroundColor: UIColor {
            switch self {
            case .success:
                return .green
            case .error:
                return .red
            case .warning:
                return .yellow
            case .custom(let theme, _):
                return theme.backgroundColor
            }
        }
        
        var title: String? {
            switch self {
                
            case .success:
                return "successMessageTitle".toastLocalization
            case .error:
                return "errorMessageTitle".toastLocalization
            case .warning:
                return "warningMessageTitle".toastLocalization
            case .custom(_, let components):
                return components.title
            }
        }
        var body: String? {
            switch self {
                
            case .success(let text):
                return text
            case .error(let text):
                return text
            case .warning(let text):
                return text
            case .custom(_, let components):
                return components.body
            }
        }
        var image: UIImage? {
            switch self {
                
            case .success:
                return UIImage(systemName: "checkmark.seal.fill")?
                    .withTintColor(.white)
                    .withRenderingMode(.alwaysOriginal)
            case .error:
                return UIImage(systemName: "xmark.seal.fill")?
                    .withTintColor(.white)
                    .withRenderingMode(.alwaysOriginal)
            case .warning:
                return UIImage(systemName: "exclamationmark.triangle.fill")?
                    .withTintColor(.white)
                    .withRenderingMode(.alwaysOriginal)
            case .custom(_, let components):
                return components.image
            }
        }
        
    }
    
    
    //MARK: Properties
    static let shared = ToastManager()
    private var window: UIWindow? = UIApplication.shared.keyWindow
    private var message: Message!
    private var bottomAnchor: NSLayoutConstraint!
    private var toastViews: [ToastView?] = []
    
    //MARK: Methods
    private init() {}
    
    func show(message: Message) {
        let toast: ToastView? = ToastView()
        toastViews.forEach({
            hideBanner(view: $0)
        })
        toastViews.append(toast)
        
        self.message = message
        createBannerWithInitialPosition(for: toast)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.hideBanner(view: toast)
        }
    }
    
    private func createBannerWithInitialPosition(for toastView: ToastView?) {
        guard let toastView = toastView, let window = window else { return }
        toastView.set(message: message)
        window.addSubview(toastView)
        let guide = window.safeAreaLayoutGuide
        toastView.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor = toastView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 200)
        bottomAnchor.isActive = true
        toastView.trailingAnchor.constraint(lessThanOrEqualTo: guide.trailingAnchor, constant: -20).isActive = true
        toastView.leadingAnchor.constraint(greaterThanOrEqualTo: guide.leadingAnchor, constant: 20).isActive = true
        toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        window.layoutIfNeeded()
        animateBannerPresentation()
    }
    
    private func animateBannerPresentation() {
        if KeyboardStateManager.shared.isVisible {
            bottomAnchor.constant = -KeyboardStateManager.shared.keyboardOffset
        } else {
            bottomAnchor.constant = -20
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4) {[weak self] in
            self?.window?.layoutIfNeeded()
        }
    }
    
    private func hideBanner(view: ToastView?) {
        UIView.animate(withDuration: 0.5, animations: {
            view?.alpha = 0
        }) { _ in
            view?.removeFromSuperview()
        }
    }
}
