//
//  CountriesResultViewController.swift
//  Experiences
//
//  Created by Ahmed Raslan on 08/11/2023.
//

import UIKit

class CountriesResultViewController: UIViewController {
    
    //MARK: Outlets Initialization
    
    //MARK: Variables Declaration
    var countries: [Country]
    weak var delegate: CountryCodeProtocol?
    let tableView = UITableView()
    
    //MARK: Initialization
    required init(countries: [Country], delegate: CountryCodeProtocol) {
        self.countries = countries
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: SetupUI
    private func setupUI(){
        view.addSubview(tableView)
        title = "selectCountry".localized
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: CountryCodeTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension CountriesResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CountryCodeTableViewCell()
        cell.configureCell(country: countries[indexPath.row])
        return cell
    }
}
extension CountriesResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectCountryCode(code: countries[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
