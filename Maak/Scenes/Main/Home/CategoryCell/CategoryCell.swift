//
//  CategoryCell.swift
//  Maak
//
//  Created by AAIT on 15/01/2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
     }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImage.image = nil
        categoryNameLabel.text = nil
    }
    
    func configCell(image: String, categoryName: String){
        categoryImage.setWith(url: image)
        categoryNameLabel.text = categoryName
    }

}
