//
//  ToastShower.swift
//  WithYou
//
//  Created by Ahmed Raslan on 29/08/2023.
//

import Foundation

protocol ToastShower {
    func showSuccessToast(with text: String?)
    func showErrorToast(with text: String?)
    func showWarningToast(with text: String?)
}

extension ToastShower {
    func showSuccessToast(with text: String?) {
        ToastManager.shared.show(message: .success(text: text))
    }
    func showErrorToast(with text: String?) {
        //dismissKeyboard()
        ToastManager.shared.show(message: .error(text: text))
    }
    
    func showWarningToast(with text: String?) {
        ToastManager.shared.show(message: .warning(text: text))
    }
    
    
    
    
}
