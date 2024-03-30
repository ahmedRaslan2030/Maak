//
//  UploadData.swift
//  WithYou
//
//  Created by Ahmed Raslan on 05/09/2023.
//

import Foundation

struct UploadData {
    var data: Data
    var mimeType: mimeType
    var name: String
    var nameWithExtension: String {
        self.name.trimWhiteSpace().appending(mimeType.extension)
    }
    var fileName: String = Data().description
}

enum mimeType: String {
    case jpeg = "image/jpeg"
    case pdf = "application/pdf"
    case m4a = "audio/x-m4a"
    case mp4 = "video/mp4"
    
    fileprivate var `extension`: String {
        switch self {
        case .jpeg:
            return ".jpeg"
        case .pdf:
            return ".pdf"
        case .m4a:
            return ".m4a"
        case .mp4:
            return ".mp4"
        }
    }
    
}


