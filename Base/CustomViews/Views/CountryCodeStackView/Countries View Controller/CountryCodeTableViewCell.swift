//
//  CountryCodeTableViewCell.swift
//  Experiences
//
//  Created by Ahmed Raslan on 08/11/2023.
//

import UIKit

class CountryCodeTableViewCell: UITableViewCell {
    
    private var flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = UIColor(resource: .mainDarkFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var codeLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.numberOfLines = 2
        label.sizeToFit()
        label.textColor = UIColor(resource: .mainDarkFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupInitialView()
        self.resetData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupInitialView()
        self.resetData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resetData()
    }
    
    private func setupInitialView() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        let leadingStack = UIStackView(arrangedSubviews: [flagImageView, nameLabel])
        leadingStack.alignment = .center
        leadingStack.distribution = .fill
        leadingStack.spacing = 8
        leadingStack.axis = .horizontal
        let stack = UIStackView(arrangedSubviews: [leadingStack, codeLabel])
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        self.addSubview(stack)
        
        flagImageView.constrainWidth(constant: 30)
        flagImageView.constrainHeight(constant: 20)

        stack.anchor(top: self.topAnchor,
                     leading: self.leadingAnchor,
                     bottom: self.bottomAnchor,
                     trailing: self.trailingAnchor,
                     padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    private func resetData() {
        self.flagImageView.image = nil
        self.nameLabel.text = nil
        self.codeLabel.text = nil
    }
    
    func configureCell(country: Country) {
        self.flagImageView.setWith(url: country.image)
        self.nameLabel.text = country.name
        self.codeLabel.text = country.key
    }
}
