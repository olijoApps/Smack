//
//  MessageService.swift
//  Smack
//
//  Created by Tyron Spencer on 11/9/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    // Singleton:
    static let instance = MessageService()
    
    // Here we will store the channels in an array along with the messages for whichever channel is selected:
    var channels = [Channel]()
    // Now we have a place to store our channels
    var selectedChannel : Channel?
    
    //We need to append our messages to an array:
    var messages = [Message]()
    
    // Now we need a function to actually retrieve them
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                // If successful we're going to parse out the JSON:
                // We first have to create an object from the JSON response data:
                guard let data = response.data else { return }
                // We need to turn our JSON response into an ARRAY (using swiftyJSON):
                if let json = JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        
                        // So now we instantiate a NEW channel object:
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        
                        // Now to add this new channel to our channels ARRAY we created above:
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    // A function that is user to get all messages:
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_GET_MESSAGE)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                // Now to get the data and turn it into swiftyJSON
                guard let data = response.data else {return}
                if let json = JSON(data: data).array {
                    // Here we just created an array of JSON objects that were responded
                    for item in json {
                        // Now we will go through and extract the properties for each item:
                        let messageBody = item["messageBody"].stringValue
                        let id = item["_id"].stringValue
                        let userId = item["userId"].stringValue
                        let userName = item["usrerName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let channelId = item["channelId"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        // Now to create a new message object:
                        let message = Message(message: messageBody, id: id, userId: userId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, channelId: channelId, timeStamp: timeStamp)
                        
                        // and then append it to our messages array:
                        self.messages.append(message)
                    }
                    print(self.messages)
                    completion(true)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
        
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    
    // Lets create a function that dismisses all channel when user is logged OUT:
    func clearChannels() {
        channels.removeAll()
    }
}














