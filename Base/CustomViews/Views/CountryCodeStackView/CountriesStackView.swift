//
//  AppStackView.swift
//  Rubikloadboard
//
//  Created by Ahmed Raslan on 01/02/2023.
//

import UIKit

protocol CountryCodeStackDelegate: AnyObject {
    func didChooseCountry(country: Country)
}

class CountriesStackView: UIStackView {
    
    weak var delegate: CountryCodeStackDelegate?
         var countries: [Country] = [ ]
    
    //MARK: Parse JSON File
    private func parseJSONFile(fileName file: String) -> Data? {
        do {
            if let path = Bundle.main.path(forResource: file, ofType: "json"), let data = try String(contentsOfFile: path).data(using: .utf8) {
                return data
            }
        }catch {
            print("error: \(error)")
        }
        return nil
    }
    
    //MARK: Decode JSON Data
    private func decodeJSONData<T: Decodable>(jsonData: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
            return nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let data = parseJSONFile(fileName: Language.isRTL() ? "countriesAr" : "countriesEn") {
            if let countries: [Country] =  decodeJSONData(jsonData: data) {
                self.countries = countries
            }
        }
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showCountryCode)))
    }
    
    
    // MARK: - Actions -
    @objc private func showCountryCode() {
        let countriesVC = CountriesViewController(countries: self.countries, delegate: self)
        
        UIApplication.shared.windows.first?.topViewController()?.present(countriesVC, animated: true)
    }
}

// MARK: - CountryCodeProtocol -
extension CountriesStackView: CountryCodeProtocol {
    func didSelectCountryCode(code: Country) {
        self.delegate?.didChooseCountry(country: code)
    }
}
