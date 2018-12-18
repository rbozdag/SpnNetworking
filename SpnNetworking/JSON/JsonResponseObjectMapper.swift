//
//  ResponseObjectMapper.swift
//  SpnNetworking
//
//  Created by Rahmi on 4.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol JsonResponseObjectMapper {
    associatedtype T
    func convertToObject<T>(type: T.Type, data: Data?, response: URLResponse?, error: NetworkErrorEnum?) throws -> T
}

public struct ResponseObjectMapper {
    public static func convertToObject<T: Mappable>(type: T.Type, data: Data?) throws -> T {
        if let data = data, let jsonStr = String(data: data, encoding: String.Encoding.utf8), let instance = type.init(JSONString: jsonStr) {
            return instance
        }
        throw NetworkErrorEnum.mappingError
    }
    
    public static func convertToObject<T: Decodable>(type: T.Type, data: Data?) throws -> T {
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let instance = try decoder.decode(T.self, from: data)
                return instance
            } catch {
                throw NetworkErrorEnum.mappingError
            }
        }
        throw NetworkErrorEnum.mappingError
    }
}
