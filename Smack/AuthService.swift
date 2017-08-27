//
//  AuthService.swift
//  Smack
//
//  Created by Tyron Spencer on 28/8/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import Foundation
import Alamofire

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
    
    // Here we are crafting out our own web request from xCode:
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let header = [
            "Content-Type" : "application/json; charset=utf-8"
        ]
        
        let body: [String : Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        // Now to create the request: This req has a specific type of method (get, post, etc)
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    
    
    
}
















