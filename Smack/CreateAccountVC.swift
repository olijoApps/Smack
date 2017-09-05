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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    // Here we need a few default variables to keep track of the name, color etc:
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //Now we are setting the users avatar image to the one they just selected:
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    
    @IBAction func createAccountPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let name = userNameText.text , userNameText.text != "" else {return}
        guard let email = emailText.text , emailText.text != "" else {return}
        guard let pass = passwordText.text , passwordText.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(avatarName: self.avatarName, avatarColor: self.avatarColor, name: name, email: email, completion: { (success) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
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
        // Now we can create a randomly generated color:
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2) {
           self.userImg.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    // Here we can create another function that will change the placeholder text in the text fields:
    func setUpView() {
        spinner.isHidden = true
        userNameText.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName: smackPurplePlaceHolder])
    
        emailText.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: smackPurplePlaceHolder])
        
        passwordText.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: smackPurplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
}

















