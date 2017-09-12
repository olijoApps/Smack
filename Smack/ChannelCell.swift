//
//  ChannelCell.swift
//  Smack
//
//  Created by Tyron Spencer on 11/9/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    // Outlets:
    
    @IBOutlet weak var channelName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.4).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    // Here in this function we will pass in a channel object
    func configureCell(channel: Channel) {
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
    }

}
