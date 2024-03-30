//
//  BaseResponse.swift
//  WithYou
//
//  Created by Ahmed Raslan on 06/09/2023.
//

import Foundation

enum ServerResponseKey: String, Codable {
    case success
    case fail
    case unauthenticated = "unauthenticated"
    case unauthorized = "unauthorized"
    case needActive = "needActive"
    case exception
    case blocked
}


struct BaseResponse<T: Codable>: Codable {
    var key: ServerResponseKey
    var message: String
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case key
        case message = "msg"
        case data
    }
    
}

 
