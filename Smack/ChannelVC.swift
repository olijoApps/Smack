//
//  ChannelVC.swift
//  Smack
//
//  Created by Tyron Spencer on 23/8/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        // Here we are adding a "listener/observer" for when the notifications come through:
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        // Here we need to add an observer to listen for the "Channels Loaded" NOTIF
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        // Here is where we will call the getChannel function (from socketService)
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    @IBAction func addChannelPressed(_ sender: Any) {
        // we need to check if we are logged in first in order to be able to add a channel
        if AuthService.instance.isLoggedIn {
            // First we have to instantiate the view controller:
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        if AuthService.instance.isLoggedIn {
            // Show profile page - here we can work with our XIB file
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    func userDataDidChange(_ notif: Notification) {
        setupUserInfo()
    }
    
    // This is the selctor function to listen for the NOTIFS (channelsLoaded)
    @objc func channelsLoaded(_ notif: Notification) {
        tableView.reloadData()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
            tableView.reloadData()
        }
    }
    
    // CellForRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ChannelCell {
            // Create a variable for a specific chanel we want to pass into it
            let channel = MessageService.instance.channels[indexPath.row]
            
            // Now to configure the cell
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // NumberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    // NumberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    // Create the function to utilise the built method for selecting a table item:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        
        // So now after the channel has been selected, we want the chatVC to slide back over:
        self.revealViewController().revealToggle(animated: true)
    }

}













