//
//  MainServices.swift
//  Maak
//
//  Created by AAIT on 15/01/2024.
//

import Alamofire

enum MainServices {
    case home
    case categoryDetails(categoryId: Int)
    case services(subCategoryId: Int)
    case createOrder(providerType: String,
                     subCategoryId: Int,
                     services: String,
                     lat: String,
                     lng: String ,
                     mapDesc: String,
                     destinationLat: String?,
                     destinationLng: String?,
                     destinationMapDesc: String?,
                     notes: String)
    
    case notifications
    case notificationsCount
    case deleteNotification(notificationId: String)
}

extension MainServices: APIRouter {
    var method: HTTPMethod {
        switch self {
        case .home , .categoryDetails, .services, .notifications, .notificationsCount:
            return .get
            
        case .createOrder:
            return .post
        case .deleteNotification:
             return  .delete
        }
    }

    var path: String {
        switch self {
            
        case .home:
            return "home"
            
        case let .categoryDetails(categoryId):
            return "categories/\(categoryId)"
            
        case let .services(subCategoryId):
            return "services/\(subCategoryId)"
            
        case .createOrder:
            return "orders"
            
        case .notifications:
           return "notifications"
            
        case .notificationsCount:
            return "count-notifications"
            
        case .deleteNotification(notificationId: let notificationId):
            return "delete-notification/\(notificationId)"
        }
    }

    var queries: APIParameters? {
        switch self {
        case .home , .categoryDetails, .services , .createOrder,.notifications, .deleteNotification, .notificationsCount:
            return nil
        }
    }

    var body: APIParameters? {
        switch self {
        case .home , .categoryDetails, .services,.notifications, .deleteNotification, .notificationsCount:
            return nil
       
        case let .createOrder(providerType,
                          subCategoryId,
                          services,
                          lat,
                          lng,
                          mapDesc,
                          destinationLat,
                          destinationLng,
                          destinationMapDesc,
                          notes):
            
            return ["provider_type": providerType,
                    "sub_category_id": subCategoryId,
                    "services": services,
                    "lat": lat,
                    "lng": lng,
                    "map_desc": mapDesc,
                    "destination_lat": destinationLat,
                    "destination_lng": destinationLng,
                    "destination_map_desc": destinationMapDesc,
                    "notes": notes
                   ]
            
        }
    }
}
