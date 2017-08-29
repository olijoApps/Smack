//
//  RoundedButton.swift
//  Smack
//
//  Created by Tyron Spencer on 29/8/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

// To be able to see the changes update live in the storyboard add:
@IBDesignable

class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
}
