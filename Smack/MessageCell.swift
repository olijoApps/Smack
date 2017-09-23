//
//  MessageCell.swift
//  Smack
//
//  Created by Tyron Spencer on 21/9/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
    // Outlets:
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // Below is a function to configure the cell
    
    func configureCell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        //timeStampLbl.text = message.timeStamp
    }

}
