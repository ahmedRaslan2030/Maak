//
//  OrderServices.swift
//  Maak
//
//  Created by AAIT on 30/01/2024.
//

import Alamofire

enum OrderServices {
    
    case pendingOrders(page: Int)
    case processingOrders(page: Int)
    case inProgressOrders(page: Int)
    case finishedOrders(page: Int)
    case orderDetails(id: Int)
    case refreshOrder(orderId: Int)

    case cancelOrder(orderId: Int, cancelReasonId: Int?)
    case acceptOffer(offerId: Int)
    case negotiateOffer(offerId: Int)
    
    case acceptHoldRequest(orderId: Int)
    case refuseHoldRequest(orderId: Int)
    case rateOrder(
                   orderId: Int,
                   providerStars: Double,
                   providerComment: String,
                   companyStars: Double?,
                   companyComment: String?
                 )
    case cancelReasons
    
    case payCash(orderId: Int)
}

extension OrderServices: APIRouter {
    
    var method: HTTPMethod {
        
        switch self {
       
        case .pendingOrders, .processingOrders, .inProgressOrders, .finishedOrders, .orderDetails, .refreshOrder , .cancelReasons :
            return .get
            
        case .cancelOrder , .acceptOffer, .negotiateOffer, .payCash, .acceptHoldRequest, .refuseHoldRequest, .rateOrder :
            return .post
    
        }
    }
 
    
    var path: String {
        switch self {
        case .pendingOrders:
          return  "pending-orders"
            
        case .processingOrders:
            return "processing-orders"
            
        case .inProgressOrders :
            return "in-progress-orders"
            
        case .finishedOrders:
            return "finished-orders"
            
        case let .orderDetails(id):
            return "orders/\(id)/show"
            
        case .refreshOrder(orderId: let orderId):
            return "orders/\(orderId)/refresh"

        case .cancelOrder :
            return "cancel-order"
            
        case .acceptOffer :
            return "accept-order-offer"
            
        case .negotiateOffer:
            return "offer-negotiation-request"
            
        case .cancelReasons:
          return  "cancel-reasons"
        
        case .payCash:
            return  "cash-payment"

        case .acceptHoldRequest:
            return "accept-hold-request"
        case .refuseHoldRequest:
            return "refuse-hold-request"
        case .rateOrder:
            return "rate-order"
        }
    }
   
    var queries: APIParameters? {
        
        switch self {
            
        case let .pendingOrders(page):
            return [
                "page": page
            ]
            
        case let .processingOrders(page):
            return [
                "page": page
            ]
            
            
            
        case let .inProgressOrders(page):
            return [
                "page": page
            ]
            
            
        case let .finishedOrders(page):
            return [
                "page": page
            ]
            

        case .orderDetails ,.cancelOrder ,.refreshOrder, .acceptOffer,  .negotiateOffer , .cancelReasons, .payCash , .acceptHoldRequest , .refuseHoldRequest,.rateOrder :
            return nil
 
        }
        
    }
    
    var body: APIParameters? {
        switch self {
            
        case .pendingOrders, .processingOrders, .inProgressOrders,.finishedOrders, .orderDetails , .refreshOrder , .cancelReasons:
            return  nil
            
        case let .cancelOrder(orderId, cancelReasonId):
            return [
                "cancel_reason_id" : cancelReasonId,
                "order_id" : orderId,
             ]
            
            
        case .acceptOffer(offerId: let offerId):
            return [
                "offer_id" : offerId,
            ]
            
        case .negotiateOffer(offerId: let offerId):
            return [
                "offer_id" : offerId,
            ]
            
        case let .payCash(orderId):
         return [
                "order_id" : orderId
             ]
            
        case let .acceptHoldRequest(orderId):
            return [
                   "order_id" : orderId
                ]
            
        case let .refuseHoldRequest(orderId):
            return [
                   "order_id" : orderId
                ]
            
        case .rateOrder(
            orderId: let orderId,
            providerStars: let providerStars,
            providerComment: let providerComment,
            companyStars: let companyStars,
            companyComment: let companyComment
        ):
            
            return [
                   "order_id" : orderId,
                   "provider_stars": providerStars,
                   "provider_comment": providerComment,
                   "company_stars": companyStars,
                   "company_comment":companyComment
                ]
        }
    }
    
}
