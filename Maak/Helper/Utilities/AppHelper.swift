//
//  AppHelper.swift
//
//  Created by Ahmed Raslan®
//

import UIKit
import CoreLocation

    struct AppHelper {
        
        static func changeWindowRoot(vc: UIViewController, options: UIView.AnimationOptions = .transitionCrossDissolve) {
            UIApplication.shared.windows.first?.rootViewController = vc
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            guard let window = window else {return}
            UIView.transition(with: window, duration: 0.3, options: options, animations: nil, completion: nil)
        }
        
        static func blockUser() {
            //showErrorToast(with: "Sorry,You need to login again".localized)
            UserDefaults.isLogin = false
            UserDefaults.accessToken = nil
            UserDefaults.user = nil
            let window = UIApplication.shared.windows.first { $0.isKeyWindow}
            
            guard let window = window else {return}
            
            if window.topViewController()?.isKind(of: LoginVC.self) == false {
                AppCoordinator.shared.changeFlow(navigationFlow: .auth)
            }
        }
        
        
        //MARK: - phoneNumber -

      static  func makeCallNumber(phoneNumber:String) {
          if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
          }
        }


    

    
    //MARK: - Location -
    /*
     Don't Forget to add this to Info.plist
     
     <key>LSApplicationQueriesSchemes</key>
     <array>
     <string>comgooglemaps</string>
     <string>maps</string>
     </array>
     */
    
    /*
     For more information about apple maps parameters
     https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html
     */
    static func openLocationOnMap(lat: String, long: String) {
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            UIApplication.shared.open(URL(string: "comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving")!)
        } else if UIApplication.shared.canOpenURL(URL(string:"maps://")!) {
            UIApplication.shared.open(URL(string:"maps://?saddr=&daddr=\(lat),\(long)")!)
        } else {
            print("Can't use comgooglemaps://, or maps://")
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
    }
        static func getAddressFrom(latitude: Double, longitude: Double, completion: @escaping (_ address: String?, _ city: String?, _ country: String?) -> Void) {
            let geocoder = CLGeocoder()
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            center.latitude = latitude
            center.longitude = longitude
            let location: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
            
            geocoder.reverseGeocodeLocation(location) { (placeMarks, error) in
                if (error != nil) {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    completion(nil, nil,nil)
                    return
                }
                guard let places = placeMarks, let place = places.first else {
                    completion(nil, nil , nil)
                    return
                }
                
                let addressStrings = [
                    place.subLocality,
                    place.thoroughfare,
                    place.locality,
                    place.country,
                    place.postalCode
                ]
                
                completion(addressStrings.compactMap({$0}).joined(separator: ","), place.locality, place.country)
            }
            
        }
        
        
        static func deleteUserDefaults(){
            UserDefaults.user = nil
            UserDefaults.accessToken = nil
            UserDefaults.isLogin = false
         }
        
    static  func saveUserData(_ user: User){
          UserDefaults.user = user
          UserDefaults.accessToken = user.token
          UserDefaults.isLogin = true
          UserDefaults.isNotify = user.isNotify ?? true
      }
      
}



extension AppHelper:ToastShower{}
