//
//  SpnNetworkingError.swift
//  SpnNetworking
//
//  Created by Rahmi on 2.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

public protocol NetworkErrorType {
    init(with error: NetworkErrorEnum, httpStatus: HTTPStatusCode?)
}

public enum NetworkErrorEnum: Int, Error, Codable {
    case undefined = -1000
    case notConnectedToInternet
    case cancelled
    case timedOut
    case invalidContentType
    case noAcceptableMethod
    case badParamater
    case encodingFailed
    case missingURL
    case mappingError
    case nilResponse
    case nilData
    case unknownHttpStatus
    case taskNotCreated
    case invalidChecksum
    case unsupportedURL
    case cannotFindHost

    public init(_ error: Error?) {
        guard let error = error else {
            self = NetworkErrorEnum.undefined
            return
        }

        if let mdError = error as? NetworkErrorEnum {
            self = mdError
        } else if let urlError = error as? URLError {
            self.init(urlError)
        } else if let cfNetworkError = CFNetworkErrors(error) {
            self.init(cfNetworkError)
        } else {
            self = NetworkErrorEnum.undefined
        }
    }

    public init(_ cfNetworkError: CFNetworkErrors?) {
        guard let cfNetworkError = cfNetworkError else {
            self = .undefined
            return
        }
        switch cfNetworkError {
        case .cfurlErrorCancelled:
            self = NetworkErrorEnum.cancelled
        case .cfurlErrorTimedOut:
            self = NetworkErrorEnum.timedOut
        default:
            self = NetworkErrorEnum.undefined
        }
    }

    public init(_ urlError: URLError?) {
        guard let urlError = urlError else {
            self = .undefined
            return
        }
        switch urlError {
        case URLError.cancelled:
            self = NetworkErrorEnum.cancelled
        case URLError.notConnectedToInternet:
            self = NetworkErrorEnum.notConnectedToInternet
        case URLError.timedOut:
            self = NetworkErrorEnum.timedOut
        case URLError.unsupportedURL:
            self = NetworkErrorEnum.unsupportedURL
        case URLError.cannotFindHost:
            self = NetworkErrorEnum.cannotFindHost
        default:
            self = NetworkErrorEnum.undefined
        }
    }
}

extension NetworkErrorEnum: Equatable {
    public static func == (lhs: NetworkErrorEnum, rhs: NetworkErrorEnum) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
