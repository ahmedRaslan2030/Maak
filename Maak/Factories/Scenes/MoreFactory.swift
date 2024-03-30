//
//  MoreFactory.swift
//  Maak
//
//  Created by AAIT on 11/02/2024.
//

import Foundation



final class MoreFactory {
    
    static func makeMoreVC()-> MoreVC {
        let moreVC = MoreVC()
        return moreVC
    }
    
    static func makeEditProfileVC()-> EditProfileVC {
        let editProfileVC = EditProfileVC()
        editProfileVC.hidesBottomBarWhenPushed = true
        return editProfileVC
    }
    
    
    static func makeChangePhoneVC()-> ChangePhoneVC {
        let changePhoneVC = ChangePhoneVC()
        changePhoneVC.hidesBottomBarWhenPushed = true
        return changePhoneVC
    }
    
    static func makeChangePhoneVerificationVC(phone: String, countryCode:  String, password:  String)-> ChangePhoneVerificationVC {
        let changePhoneVerificationVC = ChangePhoneVerificationVC(phone: phone, countryCode: countryCode, password: password)
        return changePhoneVerificationVC
    }
    
    static func makeChangePasswordVC()-> ChangePasswordVC {
        let changePasswordVC = ChangePasswordVC()
        changePasswordVC.hidesBottomBarWhenPushed = true
        return changePasswordVC
    }
    
    
    static func makeAboutUsVC(useCase: AppInfoEnum )-> AppInfo {
        let aboutUsVC = AppInfo(useCase: useCase)
        aboutUsVC.hidesBottomBarWhenPushed = true
        return aboutUsVC
    }
    
    static func makeGeneralSettingsVC()-> GeneralSettingsVC {
        let generalSettingsVC = GeneralSettingsVC()
        generalSettingsVC.hidesBottomBarWhenPushed = true
        return generalSettingsVC
    }
    
    
   
    static func makeFaqsVC()-> FaqsVC {
        let faqsVC = FaqsVC()
        faqsVC.hidesBottomBarWhenPushed = true
        return faqsVC
    }
    
    static func makeComplaintsVC()-> ComplaintsVC {
        let complaintsVC = ComplaintsVC()
        complaintsVC.hidesBottomBarWhenPushed = true
        return complaintsVC
    }
    
    
    static func makeAddComplaintVC()-> AddComplaintVC {
        let addComplaintVC = AddComplaintVC()
        return addComplaintVC
    }
    
    
    static func makeContactUsVC()-> ContactUsVC {
        let contactUsVC = ContactUsVC()
        contactUsVC.hidesBottomBarWhenPushed = true
        return contactUsVC
    }
    
    
    
    
    static func makeMorePopUpVC(useCase:  MorePopUpCases)-> MorePopUpVC {
        let morePopUpVC = MorePopUpVC(useCase: useCase)
        return morePopUpVC
    }
    
}
