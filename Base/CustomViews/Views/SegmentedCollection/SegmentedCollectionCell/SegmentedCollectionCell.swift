//
//  SegmentedCollectionCell.swift
//  LocationClient
//
//  Created by Ahmed Raslan on 23/09/2023.
//

import UIKit

class SegmentedCollectionCell: UICollectionViewCell {

    //MARK: - IBOutlets -
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var lineView: UIView!
    
    //MARK: - Lifecycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.nameLabel.attributedText = nil
    }
    
    //MARK: - Design -
    func setup(name: String, isSelected: Bool, with selectedColor: UIColor =  UIColor(resource: .main), and unselectedColor: UIColor =  UIColor(resource: .main)) {
        
        self.nameLabel.text = name
        self.lineView.backgroundColor = selectedColor
        self.nameLabel.textColor = isSelected ? selectedColor : unselectedColor
        self.lineView.isHidden = !isSelected
    }

}
