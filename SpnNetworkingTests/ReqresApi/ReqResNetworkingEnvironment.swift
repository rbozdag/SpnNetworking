//
//  ReqResNetworkingEnvironment.swift
//  SpnNetworkingTests
//
//  Created by Rahmi on 19.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation
@testable import SpnNetworking

enum ReqResNetworkingEnvironment: String {
    case testApi = "https://reqres.in/api"

    func toUrl() -> URL {
        return URL(string: self.rawValue)!
    }

    func getTimeoutIntervalForRequest() -> Double {
        switch self {
        case .testApi:
            return 30
        }
    }
}

extension ReqResNetworkingEnvironment {
    func load() {
        let endpointRouter = EndpointRouter(dispatcher: createAlamofireNetworkDispatch(timeoutIntervalForRequest: self.getTimeoutIntervalForRequest()))
        let url = self.toUrl()
        ReqresNetworkingConfiguration.shared = ReqresNetworkingConfiguration(baseUrl: url,
                                                                             endpointRouter: endpointRouter,
                                                                             acceptLanguage: "TR",
                                                                             uniqueDeviceID: "testdevice")
    }

    private func createAlamofireNetworkDispatch(timeoutIntervalForRequest: Double) -> NetworkDispatchType {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
        return AlamofireNetworkDispatch(configuration: configuration)
    }
}
