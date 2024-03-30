//
//  NotificationsVC.swift
//  Maak
//
//  Created by AAIT on 18/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class NotificationsVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Properties -
    private var notifications: [SingleNotification] = []
    private var currentPage = 1
    private var isLastPage: Bool = false
    private var isFetching: Bool = false
    
    
    //MARK: - Init -
 
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Events -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureInitialDesign()
        self.setupTableView()
        getNotifications(page: currentPage)
    }
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        self.title = "Notifications".localized
     }
    
    //MARK: - Logic Methods -
    
    
    //MARK: - Actions -
    @objc func refresh() {
        self.notifications = []
        self.tableView.reloadData()
        self.currentPage = 1
        self.isLastPage = false
        self.isFetching = false
        self.getNotifications(page: currentPage)
        self.tableView.refreshControl?.endRefreshing()
    }
    

}


//MARK: - Start Of TableView -
extension NotificationsVC {
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(cellType: NotificationsCell.self, bundle: nil)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.addRefresh(action: #selector(self.refresh))
    }
}
extension NotificationsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: NotificationsCell.self, for: indexPath)
        let notification = self.notifications[indexPath.row]
        cell.delegate = self
        cell.configureWith(data: notification)
        return cell
    }
}
extension NotificationsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if position > contentHeight - tableView.frame.height {
            if !isFetching && !isLastPage {
                getNotifications(page: currentPage)
            }
        }
    }

}

//MARK: -NotificationsCell Delegate
extension NotificationsVC: NotificationsCellProtocol {
    func notificationDeleted(notificationId: String) {
        deleteNotification(notificationId: notificationId)
    }
    
    
}

//MARK: - Networking -
extension NotificationsVC {
    private func getNotifications(page: Int){
        self.isFetching = true
        AppIndicator.shared.show(isGif: false)
        Task{
           
            do {
                let response = try await  MainServices.notifications.send(dataType: NotificationsModel.self)
                
                //paginations
                response.data?.notifications?.pagination?.currentPage == response.data?.notifications?.pagination?.totalPages  ?  (self.isLastPage = true) :  (self.currentPage += 1)
                
                self.isFetching = false
                
                self.notifications = response.data?.notifications?.data ?? []
                 self.tableView.setPlaceholder(isEmpty: notifications.isEmpty)
                self.tableView.reloadData()
            } catch {
                showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()

    }
   
    
    private func deleteNotification(notificationId: String){
        AppIndicator.shared.show(isGif: false)
        Task{
            do  {
                let response = try await  MainServices.deleteNotification(notificationId: notificationId).send(dataType: String.self)
                self.showSuccessToast(with: response.message)
                self.refresh()
            } catch {
                showErrorToast(with: error.localizedDescription)
            }
        }
        AppIndicator.shared.dismiss()
    }
  
}

