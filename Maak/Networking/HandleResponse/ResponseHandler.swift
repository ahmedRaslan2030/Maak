//
//  ResponseHandler.swift
//  WithYou
//
//  Created by Ahmed Raslan on 06/09/2023.
//

import Foundation
import UIKit

struct ResponseHandler {
    
    static let `default`: ResponseHandler = ResponseHandler()
    
    private init() {}
    
    private func decode<T: Codable>(data: Data) throws -> BaseResponse<T> {
        
        let decoder = JSONDecoder()
        let object  = try decoder.decode(BaseResponse<T>.self, from: data)
        
        return object
    }
    
    
    func handle<T: Codable>(data: Data, to type: T.Type) throws -> BaseResponse<T> {
        do {
            
            let decoder = JSONDecoder()
            let object  = try decoder.decode(BaseResponse<T>.self, from: data)
            
            switch object.key {
            case .success:
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                window?.endEditing(true)
                return object
            case .fail:
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                window?.endEditing(true)
                throw ResponseError.server(message: object.message)
            case .unauthenticated, .unauthorized:
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                window?.endEditing(true)
                showWarningToast(with: "Your session has been expired,Please Login again".localized)
                AppHelper.blockUser()
                return object
                
            case .blocked:
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                window?.endEditing(true)
                showWarningToast(with: "Your account is blocked".localized)
                AppHelper.blockUser()
                return object
                
            case .needActive:
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                window?.endEditing(true)
                return object
            case .exception:
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                window?.endEditing(true)
                throw ResponseError.serverError
            }
            
        }  catch DecodingError.keyNotFound(let key, let context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            print(context.codingPath)
            throw ResponseError.unableToDecodeResponse
        } catch DecodingError.valueNotFound(let type, let context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            print(context.codingPath)
            throw ResponseError.unableToDecodeResponse
        } catch DecodingError.typeMismatch(let type, let context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            print(context.codingPath)
            throw ResponseError.unableToDecodeResponse
        } catch DecodingError.dataCorrupted(let context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            print(context.codingPath)
            throw ResponseError.unableToDecodeResponse
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            if error as? ResponseError != nil {
                throw error
            } else {
                throw ResponseError.unableToDecodeResponse
            }
        }
    }
    
    
    
}


extension ResponseHandler:ToastShower{}
