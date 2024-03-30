//
//  IntroVC.swift
//  Maak
//
//  Created by AAIT on 24/12/2023.
//

import UIKit

final class IntroVC: BaseVC {
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    // MARK: - Properties -
    
    private var image: String?
    private var titleText: String?
    private var body: String?
    private var tagNumber: Int = 0
    
    // MARK: - Init -
    
   
    init(image: String?, title: String?, body: String?, tag: Int){
        self.image = image
        self.titleText = title
        self.body = body
        self.tagNumber = tag
        super.init(nibName: nil, bundle: nil)
    }
    
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
    }
    
    // MARK: - Design -
    
    func setData() {
        self.view.backgroundColor =  .white
        self.view.tag = tagNumber
        self.titleLabel.text = titleText
        self.bodyLabel.text = body
        self.imageView.image = UIImage(named: image ?? "")
        self.imageView.contentMode = .scaleAspectFit
    }
}

