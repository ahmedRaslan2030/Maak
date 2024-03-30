//
//  AuthModel.swift
//  Maak
//
//  Created by AAIT on 01/01/2024.
//

import Foundation

// MARK: - Country
struct Country: Codable, GeneralPickerModel {
   
    
    let id: Int
    let name, key: String
    let image: String
    
    
    var pickerId: Int {return id }
    
    var pickerTitle: String {return name }
    
    var pickerImage: String  {return image  }
    
    var pickerSlug: String {return key  }
}


// MARK: - Datum
struct City: Codable ,  GeneralPickerModel {
    let id: Int
    let name: String
    
    
    var pickerId: Int {return id  }
    
    var pickerTitle: String {return name  }
    
    var pickerImage: String {return   ""}
    
    var pickerSlug: String {return name }
    
}

// MARK: - DataClass
struct User: Codable {
    let id: Int?
    let firstName, lastName, username: String?
    let cityID: Int?
    let email, countryCode, phone, fullPhone: String?
    let image: String?
    let lang: String?
    let isNotify: Bool?
    let token: String?
    let countryID: Int?
    let countryName: String?
    let active, isBlocked, isApproved: Bool?
    let walletBalance: String?
    let regionId: Int?
    let regionName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case cityID = "city_id"
        case email
        case countryCode = "country_code"
        case phone
        case fullPhone = "full_phone"
        case image, lang
        case isNotify = "is_notify"
        case token
        case countryID = "country_id"
        case countryName = "country_name"
        case active
        case isBlocked = "is_blocked"
        case isApproved = "is_approved"
        case walletBalance = "wallet_balance"
        case regionId = "region_id"
        case regionName = "region_name"
    }
}


enum VerificationType {
    case activation , forgetPassword 
}
