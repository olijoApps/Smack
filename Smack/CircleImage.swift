//
//  CircleImage.swift
//  Smack
//
//  Created by Tyron Spencer on 5/9/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit


@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        setUpView()
    }

    func setUpView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }

}
