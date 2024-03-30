//
//  AboutUsVC.swift
//  Maak
//
//  Created by AAIT on 13/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class AppInfo: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var contentTextView: UITextView!

    
    //MARK: - Properties -
    
    private var useCase: AppInfoEnum = .aboutUs
     
    
    //MARK: - Init -
 
    init(useCase: AppInfoEnum ) {
        self.useCase = useCase
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureInitialDesign()
        self.useCase == .aboutUs ? getAboutUs() : getTerms()
    }
    
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        
        useCase == .aboutUs ? (self.title = "About us".localized ): (self.title = "terms and conditions".localized )
        self.view.backgroundColor = UIColor(resource: .secondaryBackground)
    }
    
 
    
 
}


//MARK: - Networking -
extension AppInfo {
    private func getAboutUs() {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await MoreServices.aboutUs.send(dataType: String.self)
                
                contentTextView.attributedText = response.data?.htmlToAttributedString
 
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
       
   }
    
    private func getTerms() {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await MoreServices.terms.send(dataType: String.self)
                
                contentTextView.attributedText = response.data?.htmlToAttributedString
 
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
       
   }
}

 
enum AppInfoEnum {
    case terms , aboutUs
}
