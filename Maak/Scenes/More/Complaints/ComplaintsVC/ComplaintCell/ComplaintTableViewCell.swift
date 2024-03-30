//
//  ComplaintTableViewCell.swift
//  Maak
//
//  Created by AAIT on 15/02/2024.
//

import UIKit

class ComplaintTableViewCell: UITableViewCell {
    
    @IBOutlet weak var complaintTitleLabel: UILabel!
    @IBOutlet weak var complaintDetailsLabel: UILabel!
    @IBOutlet weak var complaintTimeLabel: UILabel!
    @IBOutlet weak var complaintStatusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        complaintTitleLabel.text = nil
        complaintDetailsLabel.text = nil
        complaintTimeLabel.text = nil
        complaintStatusLabel.text = nil

    }
    
    
    func configCell(complaint: Complaint){

    complaintTitleLabel.text = complaint.title
    complaintDetailsLabel.text = complaint.content
    complaintTimeLabel.text = complaint.createdAt
    Language.isRTL() ? ( complaintStatusLabel.text = complaint.statusText ) :  ( complaintStatusLabel.text = complaint.status )
        
    }
    
}
