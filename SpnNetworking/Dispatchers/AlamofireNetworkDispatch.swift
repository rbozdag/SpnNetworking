//
//  NetworkDispatch.swift
//  SpnNetworking
//
//  Created by Rahmi on 1.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation
import Alamofire

public class AlamofireNetworkDispatch: NetworkDispatchType {
    private let session: SessionManager

    public init(configuration: URLSessionConfiguration, serverTrustPolicyManager: ServerTrustPolicyManager? = nil) {
        self.session = SessionManager(configuration: configuration, serverTrustPolicyManager: serverTrustPolicyManager)
        self.session.startRequestsImmediately = false
    }

    public func execute(urlRequest: URLRequest, completion: @escaping NetworkDispatchCompletion) -> URLSessionTask? {
        let dataRequest = session.request(urlRequest).response { dataResponse in
            completion(dataResponse.data, dataResponse.response, dataResponse.error)
        }
        return dataRequest.task
    }
}
