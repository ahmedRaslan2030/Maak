//
//  FCMModels.swift
//  Maak
//
//  Created by AAIT on 16/03/2024.
//

import Foundation

enum NotificationType: String, Codable {
    case userDeleted = "user_deleted"
    case block
    case unblocked
    case adminNotify = "admin_notify"
    
    case holdingRequestFinished = "holding_request_finished"
    case assignedProvider = "assigned_provider"
    case acceptNegotiationRequest = "accept_negotiation_request"
    case refuseNegotiationRequest = "refuse_negotiation_request"
    case statusChanged = "status_changed"
    case storeInvoice = "store_invoice"
    case newPriceOffer = "new_price_offer"
    case orderFinished = "order_finished"
    
    case newMessage = "new_message"


}








enum FCMValueKeys: String {
    case type
    case orderId = "order_id"
    case roomId = "room_id"
    case sender = "sender"
    case receiver = "receiver"
    case receiverID = "receiver_id"
    case receiverName = "receiver_name"
    case receiverImage = "receiver_image"
}

