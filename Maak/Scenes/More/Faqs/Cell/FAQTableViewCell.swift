//
//  FAQTableViewCell.swift
//  rokn-elmasa
//
//  Created by Ahmed Raslan on 14/08/2023.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         selectionStyle = .none
    }
    
    func configureCell(question: Fqs) {
        self.question.text = question.question
        answer.text = question.answer
        (question.isExpanded == true) ? (containerView.backgroundColor = UIColor(resource: .secondaryWithAlpha)) :  (containerView.backgroundColor = UIColor(resource: .secondaryBackground))
        (question.isExpanded == true) ? (questionView.backgroundColor = .clear) :  (questionView.backgroundColor = UIColor(resource: .border))
        
        (question.isExpanded == true) ? (answerView.backgroundColor = .clear) :  (answerView.backgroundColor = UIColor(resource: .border))
        answerView.isHidden =  !(question.isExpanded ?? false)
    }
}
