//
//  DropDownListResultVC.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import UIKit

final class DropDownListResultVC: UIViewController {
    
    //MARK: - Properties -
    var items: [DropDownItem]
    var delegate: DropDownTextFieldViewListDelegate
    let tableView = UITableView()
    let headerTitle: String?
    
    //MARK: - Init -
    init(items: [DropDownItem], delegate: DropDownTextFieldViewListDelegate, title: String?) {
        self.items = items
        self.delegate = delegate
        self.headerTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        title = headerTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(cellType: DropDownListCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
}

extension DropDownListResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.setPlaceholder(isEmpty: items.isEmpty, separator: .singleLine)
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DropDownListCell()
        cell.setup(item: self.items[indexPath.row])
        return cell
    }
}
extension DropDownListResultVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = self.items[indexPath.row]
        self.dismiss(animated: false) {
            self.delegate.didSelect(item: selectedItem)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}



