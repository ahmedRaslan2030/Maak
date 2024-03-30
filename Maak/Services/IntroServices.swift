//
//  IntroNetwork.swift
//  Artist
//
//  Created by AAIT on 29/08/2023.
//


import Alamofire

enum IntroServices {
   case intros
}

extension IntroServices: APIRouter {
    
    var method: HTTPMethod {
        
        switch self {
       
        case .intros: return .get
            
        }
    }
    
    
    var path: String {
        switch self {
        case .intros:
          return  "intros"
        }
    }
   
    var queries: APIParameters? {
        return nil
    }
    
    var body: APIParameters? {
        return nil
    }
    
}
