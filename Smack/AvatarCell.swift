//
//  AvatarCell.swift
//  Smack
//
//  Created by Tyron Spencer on 3/9/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    // Lets set up the view and some functions:
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    
    
}
