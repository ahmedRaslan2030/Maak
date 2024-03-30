//
//  MoreModels.swift
//  Maak
//
//  Created by AAIT on 12/02/2024.
//

import Foundation


// MARK: - Faqs
struct Fqs: Codable {
    let id: Int?
    let question, answer: String?
    var isExpanded: Bool?
}
 
// MARK: - ComplaintModel
struct ComplaintsModel: Codable {
    let pagination: Pagination?
    let data: [Complaint]
}


// MARK: - Complaint
struct Complaint: Codable {
    let id: Int?
    let title: String?
    let status, statusText, content, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, status
        case statusText = "status_text"
        case content
        case createdAt = "created_at"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let totalItems, countItems, perPage, totalPages: Int?
    let currentPage: Int?
    let nextPageURL, pervPageURL: String?

    enum CodingKeys: String, CodingKey {
        case totalItems = "total_items"
        case countItems = "count_items"
        case perPage = "per_page"
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextPageURL = "next_page_url"
        case pervPageURL = "perv_page_url"
    }
}



enum ComplaintStatus: String {
    case new
    case solved
}

enum ComplaintsTypeEnum: String{
    case  generic
    case order
}
