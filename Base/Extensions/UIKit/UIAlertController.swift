//
//  UIAlertController.swift
//  Maak
//
//  Created by AAIT on 08/02/2024.
//

 import UIKit

extension UIAlertController {
    
    func showAlert(title: String?, message: String?, andAction actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .default, handler: nil)],from controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach({alert.addAction($0)})
        controller.present(alert, animated: true, completion: nil)
    }
}
