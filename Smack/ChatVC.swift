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
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var UITextBox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector (ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) // Swipe gesture
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer()) // Tap gesture
        
        
        // We need a function for userDataDidChange, but first we need an observer for it:
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        // Now to add the observer to listen for the above notification:
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        // So when we load up the App we're going to check if the user is logged in - if so then we will call the function: findUserByEmail:
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        
    }
    
    func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            // Get channels
            onLoginGetMessages()
        } else {
            channelNameLbl.text = "Please Log In"
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? "" // If it cant find the title set it to an empty string!
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }
    
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = UITextBox.text else {return}
            
            // Now we are ready to call the function: addMessage from our socketService file
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.UITextBox.text = ""
                    self.UITextBox.resignFirstResponder()
                }
            })
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                // Show channels
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channels yet!"
                }
            }
        }
    }
    
    // This is where we call the "onLoginGetMessages" function above:
    func getMessages() {
        // To call that function we need the channelId:
        // First we need to unwrap it:
        
        guard let channelId = MessageService.instance.selectedChannel?.id else {return} // This line unwraps the id
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                
            } else {
                
            }
        }
        
        
    }

}















