//
//  Constants.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/5/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import Foundation

typealias callback = (_ success: Bool) -> ()

let BASE_API_URL = "http://127.0.0.1:3005/api/v1"

let GET_ALL_FT = "\(BASE_API_URL)/foodtruck"
let GET_ALL_FT_REVIEWS = "\(BASE_API_URL)/foodtruck"
let POST_ADD_NEW_FT = "\(BASE_API_URL)/foodtruck"
let POST_ADD_NEW_REVIEW = "\(BASE_API_URL)/foodtruck"

let POST_REGISTER_USER = "\(BASE_API_URL)/register"
let POST_LOGIN_USER = "\(BASE_API_URL)/login"

let DEFAULTS_REGISTERED = "isRegistered"
let DEFAULTS_AUTHENTICATED = "isAuthenticated"
let DEFAULTS_EMAIL = "email"
let DEFAULTS_TOKEN = "authToken"
