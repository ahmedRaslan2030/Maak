//
//  SliderCell.swift
//  LocationClient
//
//  Created by Ahmed Raslan on 23/09/2023.
//

import UIKit

class SliderCell: UICollectionViewCell {

    //MARK: - IBOutlets -
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - properties -
    var cornerRadius: CGFloat = 8.0 {
        didSet {
//            self.layoutSubviews()
//            self.setupInitialDesign()
        }
    }
    
    //MARK: - Lifecycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupInitialDesign()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
        
        // Improve scrolling performance with an explicit shadowPath
    
    }
    
    
    //MARK: - Design Methods -
    private func setupInitialDesign() {
        self.add(cornerRadius: cornerRadius, for: contentView)
    }
    func add(cornerRadius: CGFloat, for contentView: UIView) {
  
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        
        
        // Apply a shadow
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 1
        layer.shadowColor =  UIColor(resource: .shadow).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func configCell(image: String){
        self.imageView.setWith(url: image)
    }
}
