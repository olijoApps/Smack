//
//  AvatarCell.swift
//  Smack
//
//  Created by Tyron Spencer on 3/9/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

// We need to work out whether the cell is light or dark, for that we'll use an enum:
enum AvatarType {
    case dark
    case light
}


class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    // Lets set up the view and some functions:
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func configureCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    
    
}
