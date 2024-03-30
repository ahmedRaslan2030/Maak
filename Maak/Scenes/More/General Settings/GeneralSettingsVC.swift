//
//  GeneralSettingsVC.swift
//  Maak
//
//  Created by AAIT on 13/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class GeneralSettingsVC: BaseVC {
    
    //MARK: - IBOutlets -
    
    @IBOutlet private weak var notificationsSwitch: UISwitch!
    @IBOutlet private weak var notificationsSoundSwitch: UISwitch!
    
    //MARK: - Properties -
    
    
   
    
    //MARK: - Init -
 
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureInitialDesign()

    }
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        self.title = "General Settings".localized
        view.backgroundColor = UIColor(resource: .secondaryBackground)
        notificationsSwitch.isOn = UserDefaults.isNotify
        notificationsSoundSwitch.isOn = UserDefaults.notificationsSoundOn
    }
    
    //MARK: - Logic Methods -
    
    
    //MARK: - Actions -
    
    @IBAction func appNotificationsSwitch(_ sender: UISwitch) {
        switchNotificationsState()
    }
    
    @IBAction func  notificationsSoundSwitch(_ sender: UISwitch) {
        UserDefaults.notificationsSoundOn.toggle()
    }
}


//MARK: - Networking -
extension GeneralSettingsVC {
    
    private func switchNotificationsState(){
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await MoreServices.switchNotifications.send(dataType: NotificationsSwitchResponse.self)
                
                UserDefaults.isNotify = response.data?.notify ?? true
           
 
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
       
    }
    
}

 
