//
//  MoreServices.swift
//  Maak
//
//  Created by AAIT on 30/01/2024.
//

import Alamofire

enum MoreServices {
    
    case getProfile
    case regions
    case regionsByCountry(countryId: Int)
    case citiesByRegion(regionId: Int)
    case updateProfile(firstName: String, lastName: String, userName: String, email: String, cityId: Int , nationality: String)
    case checkPassword(password: String)
    case changePhoneSendCode(countryCode: String, phone: String, password: String)
    case changePhoneResendCode(countryCode: String, phone: String, password: String)
    case changePhoneCheckCode(countryCode: String, phone: String, code: String)
    
    case updatePassword(password: String, oldPassword: String)
    case changeLanguage(lang: String)
    case switchNotifications
    case aboutUs
    case terms
    case addComplaint(type: String, title: String, content: String)
    case complaints(type: String, page: Int)
    case faqs
    case contactUs(name: String, phone: String, content: String)
    case logOut
    case deleteAccount
    
}

extension MoreServices: APIRouter {
    var method: HTTPMethod {
        switch self {
            
        case .faqs,.complaints, .aboutUs,.terms ,.getProfile, .citiesByRegion , .regions , .regionsByCountry:
            return .get
            
        case .logOut:
            return .delete
            
        case .deleteAccount, .contactUs, .addComplaint, .updatePassword , .checkPassword , .changePhoneSendCode , .changePhoneResendCode , .changePhoneCheckCode,.updateProfile:
            return .post
            
        case .switchNotifications , .changeLanguage:
            return .patch
       
     
        
       
        }
    }

    var path: String {
        switch self {
            
        case .getProfile:
            return "profile"
        case .regions:
            return "regions"
            
        case let .regionsByCountry(countryId):
            return "country/\(countryId)/regions"
            
        case let .citiesByRegion(regionId):
            return "region/\(regionId)/cities"
        case .updateProfile:
            return "update-profile"
        case .checkPassword:
            return "check-password"
        case .changePhoneSendCode:
            return "change-phone-send-code"
        case .changePhoneResendCode:
            return "change-phone-resend-code"
        case .changePhoneCheckCode:
            return "change-phone-check-code"
        case .updatePassword:
            return "update-passward"
        case .changeLanguage:
            return "change-lang"
        case .switchNotifications:
            return "switch-notify"
        case .aboutUs:
            return "about"
        case .terms:
            return "terms"
        case .addComplaint:
            return "new-complaint"
        case .complaints:
            return "complaints"
        case .faqs:
            return "fqss"
        case .contactUs:
           return "contact-us"
        case .logOut:
            return "sign-out"
        case .deleteAccount:
            return "delete-account"
 
        }
    }

    var queries: APIParameters? {
        switch self {
            
 
            
        case .changeLanguage(lang: let lang):
            return [
                "lang" : lang
            ]
            
            
        case .complaints(type: let type, page: let page):
            return [
                "type" : type,
                "page" : page
            ]
            
            
        case .logOut:
            return [
                "device_id": uuid,
            ]

        case .updateProfile , .deleteAccount, .contactUs, .faqs, .aboutUs,.terms ,.addComplaint, .switchNotifications, .checkPassword , .changePhoneSendCode, .changePhoneResendCode, .changePhoneCheckCode,.updatePassword, .getProfile,.regions , .citiesByRegion ,.regionsByCountry:
            return nil
       
       
        }
    }

    var body: APIParameters? {
        switch self {
 
            
        case .logOut, .faqs, .complaints, .aboutUs, .terms, .switchNotifications, .changeLanguage,.getProfile , .regions , .citiesByRegion, .regionsByCountry:
            return nil

        case .updateProfile(firstName: let firstName, lastName: let lastName, userName: let userName, email: let email, cityId: let cityId, nationality: let nationality):
            
            return [
                "first_name": firstName,
                "last_name": lastName,
                "username": userName,
                "email": email,
                "city_id": cityId,
                "nationality": nationality,
                "_method": "put"
               ]
            
            
        case .checkPassword(password: let password):
            return [
                "password": password
               ]
            
            
        case .changePhoneSendCode(countryCode: let countryCode, phone: let phone, password: let password):
            
            return [
                "country_code": countryCode,
                "phone": phone,
                "password": password
               ]
            
            
        case .changePhoneResendCode(countryCode: let countryCode, phone: let phone, password: let password):
            
            return [
                "country_code": countryCode,
                "phone": phone,
                "password": password
               ]
            
        case .changePhoneCheckCode(countryCode: let countryCode, phone: let phone, code: let code):
            
            return [
                "country_code": countryCode,
                "phone": phone,
                "code": code
               ]
            
            
            
            
            
        case .addComplaint(type: let type, title: let title, content: let content):
            return [
                "type": type,
                "title": title,
                "content": content
               ]
            
            
        case .contactUs(name: let name, phone: let phone, content: let content):
  
            return [
                "name": name,
                "phone": phone,
                "content": content
            ]
            
      
        case .deleteAccount:
            return [
                "device_id": uuid,
            ]
        
       
        
        case .updatePassword(password: let password, oldPassword: let oldPassword):
            return [
                "password": password,
                "old_password": oldPassword,
                 "_method" : "patch"

            ]
       
       
        }
    }
}
