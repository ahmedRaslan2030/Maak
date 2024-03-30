//
//  Artist
//  Created by Ahmed Raslan®
//

import Foundation
import UIKit


// MARK: - RouterMode

public enum NavigatorMode {
    case present
    case push
    case popToRoot
}


// MARK: - RouterProtocol

protocol Navigator: AnyObject {
    
    associatedtype Destination
    
    var navigationController: UINavigationController? { get }
    
    init(navigationController: UINavigationController?)
    
    func createVC(for destination: Destination) -> UIViewController
}


// MARK: - RouterMode

extension Navigator {
    
    func navigate(
                  destination: Destination,
                  mode: NavigatorMode,
                  animated: Bool = true,
                  modalPresentationStyle: UIModalPresentationStyle  = .automatic,
                  modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
                  completion: (() -> Void)? = nil
                  ){
        
        
        let vc = self.createVC(for: destination)
        vc.modalPresentationStyle = modalPresentationStyle
        vc.modalTransitionStyle = modalTransitionStyle
        
        switch mode {
        case .push:
            navigationController?.pushViewController(vc, animated: animated)
            
        case .present:
            navigationController?.present(vc, animated: animated, completion: completion)
      
            
        case .popToRoot:
            navigationController?.setViewControllers([vc], animated: animated)
        }
        
    }
}
