//
//  AuthService.swift
//  Smack
//
//  Created by Tyron Spencer on 28/8/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// This Auth service will handle our login, create user, register user functions etc:

class AuthService {
    
    // This will be a singleton, so there will only be 1 instance of it at a time:
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
            // now when we access AuthService.instance.isloggedIn we're going to look into our user defaults
            // and see if that exists, and then if we want to set it:
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    // Now for the AuthToken:
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    
    // Now for the user email:
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    // Here we are crafting out our own web request from xCode with a registerUser function:
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String : Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        // Now to create the request: This request has a specific type of method (get, post, etc)
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String : Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        // Now we are creating our web request, the response comes back as JSON:
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            
//            if response.result.error == nil {
//                if let json = response.result.value as? Dictionary <String,Any> {
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                }
//                self.isLoggedIn = true
//                completion(true)
//            } else {
//                completion(false)
//                debugPrint(response.result.error as Any)
//            }
            
            
            
            // The NEW way:
            
            if response.result.error == nil {
                // Here is where we add in the JSON Object from postMan:
                // We need to know how to handle a response in JSON from an API:
                // ----- JSON PARSING: Section 6, Lecture 74
                // Using SwiftyJSON:
                guard let data = response.data else {return}
                let json = JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    // Here we code up the ..ADD/USER function. This will be called from the create account screen:
    func createUser(avatarName: String, avatarColor: String, name: String, email: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String : Any] = [
            
            "name" : name,
            "email" : lowerCaseEmail,
            "avatarName" : avatarName,
            "avatarColor" : avatarColor
        ]
        
        
        Alamofire.request(URL_ADD_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
                completion(true)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
                completion(true)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    func setUserInfo(data: Data) {
        let json = JSON(data: data)
        let id = json["_id"].stringValue
        let color = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        
        UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
    }
    
    
}
















