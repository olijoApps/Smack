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
    
    // Here we will store the channels along with the messages for whichever channel is selected:
    var channels = [Channel]()
    // Now we have a place to store our channels
    
    
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
                    print(self.channels[0].channelTitle)
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}














