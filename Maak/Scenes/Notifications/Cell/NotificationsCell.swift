//
//  NotificationsCell.swift
//  ArtistUser
//
//  Created by AAIT on 17/09/2023.
//

import UIKit

protocol NotificationsCellProtocol: AnyObject{
    func notificationDeleted(notificationId: String)
}

final class NotificationsCell: UITableViewCell {
    
    //MARK: - IBOutlets -
    
    @IBOutlet private weak var orderImage: UIImage!
    @IBOutlet private weak var notificationsTitle: UILabel!
    @IBOutlet private weak var notificationDateLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    
    //MARK: - properties -?
    private var notificationId: String?
    
    weak var delegate: NotificationsCellProtocol?
    
    //MARK: - Overriden Methods-
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupDesign()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resetCellData()
    }
  
    //MARK: - Design Methods -
    private func setupDesign() {
        self.selectionStyle = .none
    }
    private func resetCellData() {
      notificationsTitle.text = nil
      notificationDateLabel.text = nil
    }
    
    //MARK: - Configure Data -
    func configureWith(data: SingleNotification) {
//        orderImage.setWith(url: data.)
        notificationId = data.id
        notificationsTitle.text = data.body
        notificationDateLabel.text = data.createdAt
        
    }
    
    
    //MARK: - Actions -

    @IBAction private func deleteNotificationAction(_ sender: UIButton) {
        delegate?.notificationDeleted(notificationId: notificationId ?? "")
    }
}
