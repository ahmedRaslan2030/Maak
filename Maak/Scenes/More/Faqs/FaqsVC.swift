//
//  FaqsVC.swift
//  Maak
//
//  Created by AAIT on 13/02/2024.
//
//  Template by Ahmed Raslan®


import UIKit

final class FaqsVC: BaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties -
    private var faqs: [Fqs] = []
 
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getFAQs()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //MARK: - Init -
 
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -  SetupUI
    private func setupUI(){
        self.title = "Frequently Asked Questions".localized
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: FAQTableViewCell.self)
        tableView.tableFooterView = .none
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
}

//MARK: -  UITableView Datasource Methods
extension FaqsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: FAQTableViewCell.self, for: indexPath)
        cell.configureCell(question: faqs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        faqs[indexPath.row].isExpanded = faqs[indexPath.row].isExpanded != true ? true : false
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

//MARK: - Networking -
    
extension FaqsVC {

 private func getFAQs() {
     AppIndicator.shared.show(isGif: false)
     Task {
         do {
             let response = try await MoreServices.faqs.send(dataType: [Fqs].self)
             
             self.faqs = response.data ?? []
             
             self.tableView.reloadData()
             
         } catch {
             self.showErrorToast(with: error.localizedDescription)
         }
         
         AppIndicator.shared.dismiss()
     }
    
}

}
