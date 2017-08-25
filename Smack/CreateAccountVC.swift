//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Tyron Spencer on 26/8/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
