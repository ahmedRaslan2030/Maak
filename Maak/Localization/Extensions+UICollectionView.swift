//
//  Extensions+UICollectionView.swift
//
//  Created by Ahmed Raslan®
//

import UIKit

extension UICollectionViewFlowLayout {
    
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return Language.isRTL() ? true : false
    }
    
}
