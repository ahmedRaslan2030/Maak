//
//  ChatServices.swift
//  Maak
//
//  Created by AAIT on 07/03/2024.
//

 import Alamofire


enum ChatServices {
    case getRoomMessages(roomId: Int, page: Int)
    case uploadFile(roomId: Int)
    case createRoomId(memberId: Int, memberType: String,order_id:Int)
    case getRooms(page: Int)
}

extension ChatServices: APIRouter {
    
    var method: HTTPMethod {
        switch self {
        case .getRoomMessages, .getRooms:
            return .get
        case .uploadFile, .createRoomId:
            return .post
        }
    }
     

    
    
    var path: String {
        switch self {
        case .getRoomMessages(roomId: let roomId,_ ):
            return "get-room-messages/\(roomId)"
        case .uploadFile(roomId: let roomId):
            return "upload-room-file/\(roomId)"
        case .createRoomId:
            return "private-room"
        case .getRooms:
            return "get-rooms"
        }
        
        
        
    }
   
    var queries: APIParameters? {
        switch self{
        case let .getRoomMessages(_ , page):
            return [
                "page" :  page
            ]
            
        case .uploadFile, .createRoomId  :
            return nil
          
        case .getRooms(page: let page):
            return [
                "page" :  page
            ]
        }
        
    }
    
  var body: APIParameters? {
  
          switch self {

          case .createRoomId(memberId: let memberId, memberType: let memberType , order_id:let order_id):
              
             return [
                "memberable_id" : memberId,
                "memberable_type" : memberType,
                "order_id" : order_id
             ]

          case .uploadFile,.getRoomMessages, .getRooms:
              return nil
         
          }
          
      }
}
 
