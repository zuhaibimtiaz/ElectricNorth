//
//  APIS.swift
//  Trough
//
//  Created by Irfan Malik on 17/12/2020.
//

import Foundation

//API MESSAGE
let STRING_SUCCESS = ""
let FAILED_MESSAGE = "Failed Please Try Again!"
let STRING_UNEXPECTED_ERROR = ""
let TIMEOUT_MESSAGE = "Request Time out"
let ERROR_NO_NETWORK = "Connection lost. Please check your internet connection and try again. "//"Internet connection is currently unavailable."

let USER_SUCCESS = "Success"
let USER_EMAIL_SUCCESS = "Email not exist"
let ADD_CUSTOMER_MESSAGE = "User added successfully !"
let PHONE_NUMBER_ALREADY_EXIST_MESSAGE = "Customer Already Exist With This Phone !"

struct API {
    static let BASE_URL                               = "http://voffice2.dillners.com/webapi/"
    static let USER_LOGIN_URL                         = BASE_URL + "api/DillnersMobile/userAuthentication"
    
}

