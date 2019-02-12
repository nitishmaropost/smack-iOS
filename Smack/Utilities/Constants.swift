//
//  Constants.swift
//  Smack
//
//  Created by maropost on 24/01/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// Url
let BASE_URL = "https://chatsmackios.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_FIND_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"

// Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)

// Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name(rawValue: "NOTIFICATIONUSERDATACHANGED")
let NOTIF_CHANNELS_LOADED = Notification.Name(rawValue: "NOTIFICATIONCHANNELSLOADED")
let NOTIF_CHANNEL_SELECTED = Notification.Name(rawValue: "NOTIFICATIONCHANNELSELECTED")

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
let SELECTED_CHANNEL = "selectedChannel"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let HEADER_BEARER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
