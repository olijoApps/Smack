//
//  AddChannelVC.swift
//  Smack
//
//  Created by Tyron Spencer on 12/9/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    // Outlets:
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var chanDesc: UITextField!
    @IBOutlet weak var bgView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }

    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text , nameTxt.text != "" else {return}
        guard let channelDesc = chanDesc.text else {return}
        // Now we have unwrapped the channel name and description
        
        // Now we can call our socket service
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        // Now to add the placeholder text color etc:
        nameTxt.attributedText = NSAttributedString(string: "name", attributes: [NSForegroundColorAttributeName:smackPurplePlaceHolder])
        
        chanDesc.attributedText = NSAttributedString(string: "description", attributes: [NSForegroundColorAttributeName:smackPurplePlaceHolder])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
