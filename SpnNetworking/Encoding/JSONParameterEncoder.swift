//
//  JSONEncoding.swift
//  SpnNetworking
//
//  Created by Malcolm Kumwenda on 2018/03/05.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws {
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            if urlRequest.value(forHTTPHeaderField: HTTPHeaderKeyEnum.contentType.rawValue) == nil {
                urlRequest.setValue(MimeTypeEnum.applicationJson.rawValue, forHTTPHeaderField: HTTPHeaderKeyEnum.contentType.rawValue)
            }
        } catch {
            throw NetworkErrorEnum.encodingFailed
        }
    }
}

