//
//  Constants.swift
//  Smack
//
//  Created by Tyron Spencer on 25/8/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import Foundation


typealias CompletionHandler = (_ Success: Bool) -> ()


// URL Constants:
let BASE_URL = "https://clucketycluck.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel"

// Colors:
let smackPurplePlaceHolder = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 0.5)

// Notification Constants:
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

// Segues:
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChanelVC"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User Defaults:
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers:
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization" : "Bearer \(AuthService.instance.authToken)",
    "Content-Type" : "application/json; charset=utf-8"
]















