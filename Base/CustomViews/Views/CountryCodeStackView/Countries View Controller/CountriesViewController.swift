//
//  CountriesViewController.swift
//  Experiences
//
//  Created by Ahmed Raslan on 08/11/2023.
//

import UIKit

protocol CountryCodeProtocol: NSObject {
    func didSelectCountryCode(code: Country)
}

class CountriesViewController: UIViewController {
    
    //MARK: Outlets Initialization
    
    //MARK: Variables Declaration
    private var countries: [Country]
    weak var delegate: CountryCodeProtocol?
    private let tableView = UITableView()
    
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
        title = "select country".localized
        let resultVC = CountriesResultViewController(countries: countries, delegate: self)
        let searchBar = UISearchController(searchResultsController: resultVC)
        searchBar.searchResultsUpdater = self
        searchBar.searchBar.placeholder = "search".localized
        navigationItem.searchController = searchBar
        
        view.addSubview(tableView)
        let barButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonItem.title = "cancel".localized
        barButtonItem.tintColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: CountryCodeTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        for view in searchBar.searchBar.subviews {
            print(view.self)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
}

extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CountryCodeTableViewCell ()
        cell.configureCell(country: countries[indexPath.row])
        return cell
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectCountryCode(code: countries[indexPath.row])
        self.dismiss(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension CountriesViewController: CountryCodeProtocol {
    func didSelectCountryCode(code: Country) {
        self.dismiss(animated: true) {
            self.delegate?.didSelectCountryCode(code: code)
        }
    }
}

extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        guard let vc = searchController.searchResultsController as? CountriesResultViewController else {return}
        let filteredCountries = self.countries.filter({$0.name.contains(text)})
        vc.countries = filteredCountries
        vc.tableView.reloadData()
    }
}
