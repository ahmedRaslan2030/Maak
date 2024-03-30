//
//  Picker.swift
//  LawProvider
//
//  Created by Ahmed Raslan on 10/07/2023.
//

import UIKit
import MobileCoreServices

class DocumentPicker: NSObject {
    
    typealias FilePickerCallback = (String, Data) -> Void
    
    var callback: FilePickerCallback?
    
    func pickFile() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
    }
}

extension DocumentPicker: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        controller.shouldShowFileExtensions = true
        
        guard let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
        let filename = url.lastPathComponent

        defer{
            DispatchQueue.main.async {
                url.stopAccessingSecurityScopedResource()
            }
        }

        do{
            let pdf = try Data(contentsOf: url)
            callback?(filename, pdf)
        }catch{
            print(error)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("File picker was cancelled")
    }
    
}

