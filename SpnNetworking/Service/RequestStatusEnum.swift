//
//  RequestStatusObserverType.swift
//  SpnNetworking
//
//  Created by Rahmi on 16.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

public enum RequestStatusEnum {
    case requestPrepared(_ request: URLRequest)
    case started(_ task: URLSessionTask)
    case response(_ data: Data, _ response: URLResponse)
    case error(_ error: NetworkErrorEnum, _ httpStatus: HTTPStatusCode?)
    case cancelled
}
