//
//  PickData.swift
//  SoltanClient
//
//  Created by samy on 29/11/2023.
//

import Foundation
import PhotosUI
import MobileCoreServices

protocol MultiPickerDelegate: AnyObject {
    func imagesDidPicked(images: [Data])
}

//MARK: - MultiImage -
class MultiImagePicker: NSObject {

    private enum Keys {
        case pickImage
        case pdf
        case camera
        case gallary
        case cancel

        var value: String {
            switch self {
            case .pickImage:
                return "Pick Image".localized
            case .pdf:
                return "Files".localized
            case .camera:
                return "Camera".localized
            case .gallary:
                return "Gallery".localized
            case .cancel:
                return "Cancel".localized

            }
        }

    }

    //MARK: - Properities -
    private var picker = UIImagePickerController()
    var configuration = PHPickerConfiguration()
    private var alert = UIAlertController(title: Keys.pickImage.value, message: nil, preferredStyle: .actionSheet)

    weak var delegate: MultiPickerDelegate?

    //MARK: - Initializers -
    override init() {
        super.init()
        self.setupAlert()
    }

    //MARK: - Private Methods -
    private func setupAlert() {
        
        let cameraAction = UIAlertAction(title: Keys.camera.value, style: .default) {
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: Keys.gallary.value, style: .default) {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: Keys.cancel.value, style: .cancel) {
            UIAlertAction in
        }

        configuration.selectionLimit = 10 // Selection limit. Set to 0 for unlimited.
        configuration.filter = .images // he types of media that can be get.

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)

    }
    private func openCamera() {
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            guard let window = window else { return }
            window.topViewController()?.present(picker, animated: true, completion: nil)
        } else {
            ToastManager.shared.show(message: .error(text: "this device has no camera"))
        }
    }
    private func openGallery() {
        //Mark: Choose multi image selected
        alert.dismiss(animated: true, completion: nil)
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard let window = window else { return }
        window.topViewController()?.present(picker, animated: true, completion: nil)

    }

    func showActionSheet() {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard let window = window else { return }
        alert.popoverPresentationController?.sourceView = window.topViewController()?.view
        window.topViewController()?.present(alert, animated: true, completion: nil)
    }
    func pickImages() {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard let window = window else { return }
        alert.popoverPresentationController?.sourceView = window.topViewController()?.view
        window.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
}

extension MultiImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        if let imageData = image.jpegData(compressionQuality: 1) {
            self.delegate?.imagesDidPicked(images: [imageData])
        }
    }
}
extension MultiImagePicker: PHPickerViewControllerDelegate {

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        guard !results.isEmpty else {
            picker.dismiss(animated: true)
            return }
       
        let items = results.map({ $0.itemProvider })

        var importedCout = 0
        
        var imageModel: [Data] = []
        
        for itemm in items {

            if itemm.canLoadObject(ofClass: UIImage.self) {
                itemm.loadObject(ofClass: UIImage.self) { image, error in
                    importedCout += 1
                    if let image = image as? UIImage, let data = image.jpegData(compressionQuality: 1) {
                        imageModel.append(
                            data
                        )
                    }
                    if importedCout == items.count {
                        DispatchQueue.main.async {
                            
                            self.delegate?.imagesDidPicked(
                                images: imageModel
                            )
                            picker.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }

    }
}
