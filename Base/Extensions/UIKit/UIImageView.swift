//
//  UIImageView.swift
//
//  Created by Ahmed Raslan®
//

import Kingfisher


extension UIImageView {
    func setWith(url: String?) {
        self.kf.indicatorType = .activity
        if let newURL = ((url ?? "")).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            self.kf.setImage(with: URL(string: newURL), placeholder: image, options: [.transition(.fade(0.2))])
            return
        }
        self.kf.setImage(with: URL(string: (url ?? "")), placeholder: image, options: [.transition(.fade(0.2))])
    }
}


class CircleImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}
