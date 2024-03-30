//
//  HeaderVeiw.swift
//  Maak
//
//  Created by AAIT on 15/01/2024.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    static let identifier = "HeaderView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(titleLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 16, y: 0, width: width - 30, height: height)
    }
    
    func configure(with title: String?, titleFont: UIFont = .systemFont(ofSize: 16, weight: .medium) ) {
        titleLabel.text = title
        titleLabel.font = titleFont
    }
}

