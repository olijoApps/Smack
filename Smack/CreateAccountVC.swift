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
    
    // Here we need a few default variables to keep track of the name, color etc:
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = userNameText.text , userNameText.text != "" else {return}
        guard let email = emailText.text , emailText.text != "" else {return}
        guard let pass = passwordText.text , passwordText.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(avatarName: self.avatarName, avatarColor: self.avatarColor, name: name, email: email, completion: { (success) in
                            if success {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
        
    @IBAction func chooseAvatarBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func changeBGColorPressed(_ sender: Any) {
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
