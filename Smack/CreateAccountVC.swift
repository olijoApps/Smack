//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Tyron Spencer on 26/8/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailText.text , emailText.text != "" else {return}
        guard let pass = passwordText.text , passwordText.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("Registered User!")
            }
        }
        
    }
    
    @IBAction func chooseAvatarBtnPressed(_ sender: Any) {
    }
    
    @IBAction func changeBGColorPressed(_ sender: Any) {
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
