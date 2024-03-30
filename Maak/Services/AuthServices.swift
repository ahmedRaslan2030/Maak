//
//  AuthServices.swift
//  Maak
//
//  Created by AAIT on 31/12/2023.
//

import Alamofire


enum AuthServices {
    
    case login(userName: String, password: String)
    
    case register(firstName: String,
                  lastName: String,
                  userName: String,
                  phone: String,
                  email: String,
                  cityId: Int,
                  password: String,
                  countryId: Int,
                  countryCode: String)
    
    
    case activate(code: String ,
                  countryCode: String,
                  phone: String)
    
    
    case forgetPasswordSendCode(countryCode: String,
                                phone: String)
    
    
    case forgetPasswordCheckCode(code: String,
                                countryCode: String,
                                phone: String)
    
    
    case resetPassword(code: String,
                        countryCode: String,
                        phone: String,
                        password: String)
    
    case countries
    
    case resendCode(countryCode: String,
                    phone: String)
    
    case cities
}


extension AuthServices: APIRouter {
    
    var method: HTTPMethod {
        
        switch self {
       
        case .login,
             .register,
             .activate,
             .forgetPasswordSendCode,
             .forgetPasswordCheckCode,
             .resetPassword:
            return .post
            
        case .countries,
                .cities,.resendCode:
            return .get
         
        }
    }
    
    
    var path: String {
        switch self {
            
        case .login:
          return  "sign-in"
            
        case .register:
            return "sign-up"
            
        case .activate:
            return "activate"
            
        case .resendCode:
            return "resend-code"
            
            
        case .forgetPasswordSendCode:
            return "forget-password-send-code"
    
        case .forgetPasswordCheckCode:
             return "forget-password-check-code"
            
            
        case .resetPassword:
             return "reset-password"
            
        case .countries:
            return "countries"
            
        case .cities:
            return "cities"
     
        }
    }
   
    var queries: APIParameters? {
        switch self {
            
        case .login,
             .register,
             .activate,
             .forgetPasswordSendCode ,
             .forgetPasswordCheckCode ,
             .resetPassword, .countries , .cities :
                    return nil
            
            
 
            

            
        case .resendCode(countryCode: let countryCode, phone: let phone):
            return [
                "country_code": countryCode,
                "phone": phone

                ]
        }
    }
    
    
    var body: APIParameters? {
        switch self {
            
        case .login(userName: let userName, password: let password):
            return [
                "username" : userName,
                "password" : password,
                "device_id": deviceId,
                "device_type": deviceType
            ]
            
        case .register(firstName: let firstName,
                       lastName: let lastName,
                       userName: let userName,
                       phone: let phone,
                       email: let email,
                       cityId: let cityId,
                       password: let password,
                       countryId: let countryId,
                       countryCode: let countryCode):
            return [
                "first_name" : firstName,
                "last_name" : lastName,
                "username" : userName,
                "phone" : phone,
                "email" : email,
                "city_id" : cityId,
                "password" : password,
                "lang" : Language.currentLang().rawValue,
                "country_id" : countryId,
                "country_code" : countryCode
            ]
            
            
            
        case .activate(code: let code, 
                       countryCode: let countryCode,
                       phone: let phone):
            
            return [
                "code" : code,
                "country_code" : countryCode,
                "phone" : phone,
                "_method": "patch",
                "device_id" : uuid
                ]
            
            
        case .forgetPasswordSendCode(countryCode: let countryCode, phone: let phone):
            return [
                 "country_code" : countryCode,
                "phone" : phone
                ]
            
            
        case .forgetPasswordCheckCode(code: let code, countryCode: let countryCode, phone: let phone):
            return [
                "code" : code,
                "country_code" : countryCode,
                "phone" : phone
                ]
            
            
            
        case .resetPassword(code: let code, countryCode: let countryCode, phone: let phone, password: let password):
            
            return [
                "code" : code,
                "country_code" : countryCode,
                "phone" : phone,
                "password" : password
                ]
     
            
        case .countries , .cities, .resendCode :
              return nil
            
        }
    }
    
}
