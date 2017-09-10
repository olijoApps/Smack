//
//  ChatVC.swift
//  Smack
//
//  Created by Tyron Spencer on 23/8/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    // OUTLETS:
    @IBOutlet weak var menuBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) // Swipe gesture
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer()) // Tap gesture
        
        // So when we load up the App we're going to check if the user is logged in - if so then we will call the function: findUserByEmail:
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        
    }

}
