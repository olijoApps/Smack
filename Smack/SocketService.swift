//
//  SocketService.swift
//  Smack
//
//  Created by Tyron Spencer on 12/9/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    // Now to create a singleton and instantiate it:
    static let instance = SocketService()
    
    // Now because this is an NSObject we need to initialise it:
    override init() {
        super.init()
    }
    
    // Now to create the socket (after adding import socketIO at the top)
    var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!) // This points to the api url
    
    // Now to create some functions to communicate with the server from our app:
    
    // To connect:
    func establishConnection() {
        socket.connect()
    }
    
    // To disConnect:
    func closeConnection() {
        socket.disconnect()
    }
    
    // Now to create the channel and send to server
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        
        // Now we are going to emit from our app to the API - found in ATOM the imported mac-chat-api (under sockets)
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    // Now to create the socket.ON
    func getChannel(completion: @escaping CompletionHandler) {
        // This is like an observer, we are listening for the event (found in ATOM.mac-chat-api)
        socket.on("channelCreated") { (dataArray, ack) in // This return an array of data of type ANY (ack: acknowledge)
            // Now to parse out that data: ChannelName, description, Id. So that we can create a new channel object
            // and append to that our message service channels array
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            
            // Now to append it:
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
        // The getChannel function above needs a listener to check for changes, this would be best suited in our CHANNELVC
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
}

















