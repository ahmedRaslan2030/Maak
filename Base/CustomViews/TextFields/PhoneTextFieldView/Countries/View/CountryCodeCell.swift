//
//  CountryCodeCell.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import UIKit

final class CountryCodeCell: UITableViewCell {
    
    //MARK: - Proprites -
    private var flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
        return imageView
    }()
    private var flagLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        label.textColor =  UIColor(resource: .secondaryLightFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init -
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
    
    //MARK: - Lifecycle -
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resetData()
    }
    
    //MARK: - Design & Data -
    private func setupInitialView() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        //flagImageView.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
        //flagImageView.backgroundColor = .red
        let stack = UIStackView(arrangedSubviews: [flagImageView, flagLabel, nameLabel, UIImageView(), codeLabel])
        
        let imageViewWidthConstraint = NSLayoutConstraint(item: flagImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        let imageViewHeightConstraint = NSLayoutConstraint(item: flagImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        flagImageView.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        self.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    private func resetData() {
        self.flagImageView.isHidden = true
        self.flagLabel.isHidden = true
        self.flagLabel.text = nil
        self.nameLabel.text = nil
        self.codeLabel.text = nil
    }
    
    func setup(country: CountryCodeItem) {
        if let flagImage = country.flag {
            #warning("use kingfisger pod to set the image")
            //self.flagImageView.setWith(string: flagImage)
            self.flagImageView.isHidden = false
            self.flagImageView.setWith(url: flagImage)
        } else if let flagEmoji = country.emoji {
            self.flagLabel.text = flagEmoji
            self.flagLabel.isHidden = false
        }
        self.nameLabel.text = country.name
        self.codeLabel.text = country.countryCode
    }
    
    
}

