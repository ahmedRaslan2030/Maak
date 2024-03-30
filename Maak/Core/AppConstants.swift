//
//  AppConstants.swift
//
//  Created by Ahmed Raslan®
//

import UIKit

var appName = {
    return "Shop Zone".coreLocalizable
}()

var appCurrency = {
    return "EGP".coreLocalizable
}()

var appDistance = {
    return "Km".coreLocalizable
}()

var appDateFormate = {
    return "yyyy-MM-dd"
}()


enum AppLanguage:String {
    case english = "en"
    case arabic = "ar"
}



let deviceId = UserDefaults.pushNotificationToken ?? "no device id for firebase for this device and this is an ios device"

let uuid = UIDevice.current.identifierForVendor?.uuidString ?? String()

let defaultLat = "23.8859"
let defaultLong = "45.0792"
let deviceType = "ios"
