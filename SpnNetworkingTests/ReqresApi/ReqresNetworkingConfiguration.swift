//
//  ReqresNetworkingConfiguration.swift
//  SpnNetworkingTests
//
//  Created by Rahmi on 19.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation
import Alamofire

@testable import SpnNetworking

struct ReqresNetworkingConfiguration {
    static var shared: ReqresNetworkingConfiguration!
    let baseUrl: URL
    let endpointRouter: EndpointRouter
    var acceptLanguage: String = "TR"
    var geolocation: String = ""
    let uniqueDeviceID: String
    var xToken: String? = nil
    
    init(baseUrl: URL, endpointRouter: EndpointRouter, acceptLanguage: String, uniqueDeviceID: String) {
        self.baseUrl = baseUrl
        self.endpointRouter = endpointRouter
        self.acceptLanguage = acceptLanguage
        self.uniqueDeviceID = uniqueDeviceID
    }
    
    func createDefaulHeader() -> RequestHTTPHeaders {
        var headers = RequestHTTPHeaders()
        headers[HTTPHeaderKeyEnum.geolocation.rawValue] = geolocation
        headers[HTTPHeaderKeyEnum.acceptLanguage.rawValue] = acceptLanguage
        headers[HTTPHeaderKeyEnum.token.rawValue] = xToken
        headers[HTTPHeaderKeyEnum.clientId.rawValue] = uniqueDeviceID
        return headers
    }
    
    mutating func setXToken(_ xToken: String?) {
        self.xToken = xToken
    }
    
    mutating func setGeoLocation(_ geolocation: String) {
        self.geolocation = geolocation
    }
    
    mutating func setAcceptLanguage(_ acceptLanguage: String) {
        self.acceptLanguage = acceptLanguage
    }
    
}
