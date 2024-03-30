//
//  ResponseError.swift
//  WithYou
//
//  Created by Ahmed Raslan on 06/09/2023.
//

import Foundation

enum ResponseError: Error {
    
    case canNotConnectToServer
    case serverError
    case unableToDecodeResponse
    case server(message: String)
    
}

extension ResponseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .canNotConnectToServer:
            return "Can not send request, please check your connection".localized
        case .serverError:
            return "There is an error in our servers and we work on it, please try again later".localized
        case .unableToDecodeResponse:
            return "unexpected error happened and we will work on it, please try again later".localized
        case .server(let message):
            return message
        }
    }
}
