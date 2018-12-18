//
//  HttpHeader.swift
//  SpnNetworking
//
//  Created by Rahmi on 17.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

public typealias RequestHTTPHeaders = [String: String]

public enum HTTPHeaderKeyEnum: String {
    case contentType = "Content-Type"
    case transferEncoding = "Transfer-Encoding"
    case setCookie = "Set-Cookie"
    case date = "Date"
    case acceptLanguage = "Accept-Language"
    case geolocation = "Geolocation"
    case checkSum = "X-CheckSum"
    case token = "X-Token"
    case clientId = "X-Client-Id"
}
