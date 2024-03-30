//
//  AuthFactory.swift
//  Maak
//
//  Created by AAIT on 26/03/2024.
//

import Foundation

final class AuthFactory {
    
    static func makeLoginVC() -> LoginVC {
        let loginVC = LoginVC()
        return loginVC
    }

    static func makeRegisterVC() -> RegisterVC {
        let registerVC = RegisterVC()
        return registerVC
    }
    
    static func makeVerificationVC(phone: String, countryCode: String, useCase: VerificationType, password: String?) -> VerificationVC {
        let verificationVC = VerificationVC(phone: phone, countryCode: countryCode, useCase: useCase, password: password)
        return verificationVC
    }
    
    
    static func makeCheckPhoneNumberVC()-> CheckPhoneVC {
        let checkPhoneVC = CheckPhoneVC()
        return checkPhoneVC
    }
    
    
    static func makeForgetPasswordVC(phone: String, countryCode: String, code: String)-> ForgetPasswordVC {
        let forgetPasswordVC = ForgetPasswordVC(phone: phone, countryCode: countryCode, code: code)
        return forgetPasswordVC
    }
    
}
