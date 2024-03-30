//
//  Language.swift
//
//  Created by Ahmed Raslan®

import UIKit

struct Language {
    
    enum Languages {
        static let en = "en"
        static let ar = "ar"
    }
    
    static func currentLanguage() -> String {
        let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
        let firstLanguage = languages.firstObject as! String
        return firstLanguage
    }
    static func setAppLanguage(lang: String) {
        UserDefaults.standard.set([lang, currentLanguage()], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        updateUIDirection()
    }
    
    static func apiLanguage() -> String {
        return self.currentLanguage().contains(Languages.ar) ? Languages.ar : Languages.en
    }
    
    static func currentLang() -> AppLanguage {
        return self.currentLanguage().contains(Languages.ar) ? .arabic : .english
    }
    
    static func isRTL() -> Bool {
        return self.currentLanguage().contains(Languages.ar) ? true : false
    }
    
    static func updateUIDirection() {
        UIPageControl.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UIStackView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UISwitch.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UIButton.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UICollectionView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITableView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITextField.appearance().textAlignment = Language.isRTL() ? .right : .left
        
        UIDatePicker.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UIPickerView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UILabel.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITextView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITextField.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    }
    
}
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    var validationLocalized: String {
        return NSLocalizedString(self, tableName: "ValidationLocalized", bundle: Bundle.main, value: "", comment: "")
    }
    var helperLocalizable: String {
        return NSLocalizedString(self, tableName: "HelperLocalizable", bundle: Bundle.main, value: "", comment: "")
    }
    var coreLocalizable: String {
        return NSLocalizedString(self, tableName: "CoreLocalizable", bundle: Bundle.main, value: "", comment: "")
    }
}
