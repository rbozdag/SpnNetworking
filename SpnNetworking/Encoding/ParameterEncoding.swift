//
//  ParameterEncoding.swift
//  SpnNetworking
//
//  Created by Rahmi on 1.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

public typealias RequestParameters = [String: Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws
}

public enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
}

public extension ParameterEncoding {
    public func encode(urlRequest: inout URLRequest,
                       parameters: RequestParameters?) throws {

        guard let parameters = parameters else { return }

        do {
            switch self {
            case .urlEncoding:
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: parameters)
            case .jsonEncoding:
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: parameters)
            }
        } catch {
            throw error
        }
    }
}
