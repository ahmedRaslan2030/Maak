//
//  BaseVC.swift
//  Maak
//
//  Created by AAIT on 24/12/2023.
//

import UIKit
import SkeletonView

class BaseVC: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Properties -
    
     lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView.image = UIImage(resource: .homeLogo)
        imageView.tintColor = .white
         imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.clipsToBounds = false
        return imageView
    }()

    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseVC()
        addKeyboardDismiss()
    }

    // MARK: - Design -

    private func setupBaseVC() {
        view.backgroundColor = UIColor(resource: .secondaryBackground)
        view.tintColor = UIColor(resource: .secondary)
        setBackTitle()
    }

    
    func addNavBarImage() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoImageView)
        logoImageView.autoresizingMask = .flexibleHeight
    }
 
  
    func setBackTitle(_ name: String? = nil, color: UIColor? = nil) {
        let backItem = UIBarButtonItem()
        backItem.title = name
        backItem.tintColor = .black
        navigationItem.backBarButtonItem = backItem
        let customFont = UIFont.systemFont(ofSize: 13)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
    }

    func showNavBar() {
        navigationController?.navigationBar.isHidden = false
    }

    func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }

    func setupNavigationBarImage() {
        // Create a navigation bar
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        navigationBar.barTintColor = UIColor.gray

 
        // Create an image view for your logo
        let logoImageView = UIImageView(image: UIImage(resource: .logo))
        logoImageView.contentMode = .scaleAspectFit

        // Set the logo's frame
        let logoWidth: CGFloat = 120.0
        let logoHeight: CGFloat = 35.0
        logoImageView.frame = CGRect(x: (navigationBar.frame.width - logoWidth) / 2,
                                     y: navigationBar.frame.height - logoHeight,
                                     width: logoWidth,
                                     height: logoHeight)

        // Add the logo image view to the navigation bar
        navigationBar.addSubview(logoImageView)

    

        // Add the navigation bar to the view
        view.addSubview(navigationBar)
    }
    
    func removeNavigationBarShadow(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(resource: .mainBackground)
        appearance.shadowColor = .clear
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    func showSkeleton(){
        view.showAnimatedGradientSkeleton()
    }
    
    func stopSkeleton(){
        view.stopSkeletonAnimation()
    }

    // MARK: - Deinit -

    deinit {
        print("\(NSStringFromClass(self.classForCoder).components(separatedBy: ".").last ?? "BaseVC") is deinit, No memory leak found")
    }
}


extension BaseVC {
    
    
    func pop(animated: Bool = true, completion: @escaping () -> Void) {
        navigationController?.popViewController(animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
}


extension BaseVC {
    
    func multiPartData(data: [Data], type: UploadTypesEnum) -> [UploadData]{
        var uploadData: [UploadData] = []
        var index: Int = 0
        
        data.forEach { file in
            uploadData.append(UploadData(data: file, mimeType: .jpeg,
                                         name: "\(type.rawValue)[\(index)]",
                                         fileName: "\(Date().timeIntervalSince1970).Jpeg"))
             index += 1
            }
        return uploadData
    }
    

}

enum UploadTypesEnum: String {
    case attachments
    case images
    case pdf_files
}
