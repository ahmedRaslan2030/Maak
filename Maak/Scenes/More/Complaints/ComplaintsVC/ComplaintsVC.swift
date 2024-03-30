//
//  ComplaintsVC.swift
//  Maak
//
//  Created by AAIT on 13/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class ComplaintsVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: TableViewContentSized!

    
    //MARK: - Properties -
    private var complaints: [Complaint] = []
    private var currentPage = 1
    private var isLastPage: Bool = false
    private var isFetching: Bool = false
    private var complaintsType: ComplaintsTypeEnum = .generic {
        didSet{
            self.refresh()
        }
    }
    
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
    }
    
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        self.title = "Complaints and Suggestions".localized
        self.setBackTitle("Complaints and Suggestions".localized)
        setupSegmentedControl()
        setupTableView()
    }
    
        private func setupSegmentedControl(){
            segmentedControl.setupSegmented(
            mainColor: UIColor(resource: .secondary),
            font: UIFont.systemFont(ofSize: 14),
            normalColor: UIColor(resource: .mainDarkFont),
            selectedColor: .white)
            
            segmentedControl.setTitle("General Complaints".localized, forSegmentAt: 0)
            segmentedControl.setTitle("Orders Complaints".localized, forSegmentAt: 1)
            segmentedControl.selectedSegmentIndex = 0
        }
    
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: ComplaintTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.addRefresh(action: #selector(self.refresh))
    }
    
    
    
    //MARK: - Logic Methods -
    
    
    //MARK: - Actions -
    
    @objc private func refresh(){
        self.complaints = []
        self.tableView.reloadData()
        self.currentPage = 1
        self.isLastPage = false
        self.isFetching = false
        self.getComplaints(type: complaintsType.rawValue, page: currentPage)
        self.tableView.refreshControl?.endRefreshing()
    }
    
    
    @IBAction private func switchSegmentControl(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
             complaintsType = .generic
         case 1:
             complaintsType = .order
         default:
            break
        }
    }
    
    @IBAction private func goToAddComplain(_ sender: UIButton){
        AppCoordinator.shared.moreNavigator?.navigate(destination: .addComplaint, mode: .push)
    }
    
}


//MARK: -  UITableView Datasource Methods
extension ComplaintsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return complaints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ComplaintTableViewCell.self, for: indexPath)
        cell.configCell(complaint: complaints[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    
  
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if position > contentHeight - tableView.frame.height {
            if !isFetching && !isLastPage {
                getComplaints(type: complaintsType.rawValue , page: currentPage)

            }
        }
    }
}


//MARK: - Networking -
extension ComplaintsVC {
    
    private func getComplaints(type: String, page: Int){
        self.isFetching = true
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await MoreServices.complaints(type: type, page: page).send(dataType: ComplaintsModel.self)
                
                if response.data?.pagination?.currentPage == response.data?.pagination?.totalPages {
                    self.isLastPage = true
                        } else {
                           self.currentPage += 1
                        }
 
                
                
                self.complaints +=  response.data?.data ?? []
                self.tableView.setPlaceholder(isEmpty: complaints.isEmpty)
                self.tableView.reloadData()
                self.isFetching = false

            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
        }
        
        AppIndicator.shared.dismiss()
    }
    
}

 
