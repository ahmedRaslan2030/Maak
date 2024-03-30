//
//  AttachedImageType.swift
//  WithYou
//
//  Created by Apple on 17/10/2023.
//

import Foundation


struct AttachedImageType {
    var type: ImageType
    var onlineImage: String?
    var offlineImage: AttachedFiles?
    
    
    init(onlineImage: String) {
        self.onlineImage = onlineImage
        self.type = .online
    }
    
    
    init(offlineImage:AttachedFiles) {
        self.offlineImage = offlineImage
        self.type = .offline
    }
}


struct AttachedFiles: Codable {
    var image: Data?
    var pdf: Data?
    var type: String?
    var id: Int?
    var file: String?
}



enum ImageType {
    case online
    case offline
}
