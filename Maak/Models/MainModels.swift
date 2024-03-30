//
//  HomeModel.swift
//  Maak
//
//  Created by AAIT on 15/01/2024.
//

import Foundation

// MARK: - HomeResponse

struct HomeResponse: Codable {
    let images: [ImageModel]
    let categories: [Category]
}

// MARK: - DataClass

struct CategoriesResponse: Codable {
    let hasNoServices: [Category]
    let hasServices: [Category]

    enum CodingKeys: String, CodingKey {
        case hasNoServices = "has_no_services"
        case hasServices = "has_services"
    }
}

// MARK: - Category

struct Category: Codable {
    let id: Int
    let name: String?
    let image: String?
    let isRequireDestination, hasServices: Bool?
    let isActive: Bool?
    let isProviderTypeEnabled: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case isRequireDestination = "is_require_destination"
        case hasServices = "has_services"
        case isActive = "is_active"
        case isProviderTypeEnabled = "is_provider_type_enabled"
    }
}

// MARK: - Image

struct ImageModel: Codable {
    let id: Int
    let image: String?
}

// MARK: - Option
//
//struct Option: Codable, SingleSelectionModel {
//    let categoryID: Int?
//    var children: [Option]?
//    let id: Int?
//    var name: String?
//    let parentID: Int?
//    let type: String?
//    var isSelected: Bool?
//    var image: String?
//
//    enum CodingKeys: String, CodingKey {
//        case categoryID = "category_id"
//        case children, id, name
//        case parentID = "parent_id"
//        case type
//    }
//}

enum ProviderTypesEnum: String {
    case individual, company

    var localizedValue: String {
        switch self {
        case .company:
            return "company".localized

        case .individual:
            return "individual".localized
        }
    }
}
//
//struct ProviderType: SingleSelectionModel {
//    var name: String?
//    var isSelected: Bool? = false
//    var image: String?
//}


// MARK: - DataClass
struct CreateOrderResponse: Codable {
    let orderID: Int?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
    }
}



struct CreateOrderServicesModel: Codable {
    var service_value: String?
    var service_id: String?
}


// MARK: - DataClass
struct NotificationsSwitchResponse: Codable {
    let notify: Bool?
}


// MARK: - NotificationsModel
struct NotificationsModel: Codable {
    let notifications: Notifications?
}

// MARK: - Notifications
struct Notifications: Codable {
    let pagination: Pagination?
    let data: [SingleNotification]?
}


// MARK: - SingleNotification
struct SingleNotification: Codable {
    let id, type, title, body: String?
    let data: NotificationData?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, type, title, body, data
        case createdAt = "created_at"
    }
}

// MARK: - NotificationData
struct NotificationData: Codable {
    let type: String?
}


// MARK: - NotificationsCount
struct NotificationsCount: Codable {
    let count: Int?
}
