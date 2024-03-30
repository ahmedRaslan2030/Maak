//
//  MoreVC.swift
//  Maak
//
//  Created by AAIT on 29/01/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class MoreVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet private weak var notificationsButton: SSBadgeButton!
    @IBOutlet private weak var tableView: UITableView!
    
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
        self.configureInitialDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavBar()
        UserDefaults.isLogin == true ?  getNotificationsCount() : ()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.showNavBar()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

    }
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        setBackTitle("More".localized)
        configureTableView()
        view.backgroundColor = UIColor(resource: .secondaryBackground)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    
    //MARK: - Actions -
    @IBAction private func goToNotifications(_ sender: UIButton){
        AppCoordinator.shared.moreNavigator?.navigate(destination: .notifications, mode: .push)
    }
}


// MARK: -   UITableViewDataSource-

extension MoreVC: UITableViewDelegate {
     

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return UserDefaults.isLogin == true ? MoreItemEnum.allCases.count : MoreVisitorItemEnum.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if UserDefaults.isLogin == true {
            let item = MoreItemEnum.allCases[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.imageView?.image = UIImage(named: item.image)
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = UIColor(resource: .mainDarkFont)
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor(resource: .border).cgColor
            return cell
        } else {
            let item = MoreVisitorItemEnum.allCases[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.imageView?.image = UIImage(named: item.image)
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = UIColor(resource: .mainDarkFont)
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor(resource: .border).cgColor
            return cell
        }
    }

  

   
}

// MARK: -  UITableViewDelegate -

extension MoreVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        return UserDefaults.isLogin == true ?    MoreItemEnum.allCases[indexPath.row].action() : MoreVisitorItemEnum.allCases[indexPath.row].action()
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}





//MARK: - Networking -
extension MoreVC {
    private func getNotificationsCount() {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await MainServices.notificationsCount.send(dataType: NotificationsCount.self)
                self.notificationsButton.badge = "\(response.data?.count ?? 0)"
                
            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
    }
}

 
