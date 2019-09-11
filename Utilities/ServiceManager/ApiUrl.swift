//
//  ApiUrl.swift
//  Demo
//
//  Created by Dark Army on 11/09/19.
//  Copyright © 2019 Dark Army. All rights reserved.
//

import Foundation

//MARK:- BASE URL
let URL_BASE                = ""
let URL_BASE_POST           = ""
let IS_FOR_DEVELOP          = true  // true for push notification work in develop app.

func getUrl(_ endPoint:String) -> String {
    return URL_BASE + endPoint
}

func postUrl(_ endPoint:String) -> String {
    return URL_BASE_POST + endPoint
}
