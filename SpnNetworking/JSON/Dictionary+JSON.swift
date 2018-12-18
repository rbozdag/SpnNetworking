//
//  Dictionary+JSON.swift
//  SpnNetworking
//
//  Created by Rahmi on 2.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String {
    public func toJsonHttpBody(option: JSONSerialization.WritingOptions = .prettyPrinted) -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: option)
    }

    public func toJsonStr(option: JSONSerialization.WritingOptions = []) throws -> String? {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: option) {
            let theJSONText = String(data: theJSONData, encoding: .utf8)
            return theJSONText
        }
        return nil
    }
}

public extension Dictionary where Key == String, Value == Any {
    public init?<T: Encodable>(encodable: T) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(encodable) {
            print("1", data)
            if let dict = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
                self.init()
                self.merge(dict, uniquingKeysWith: { val1, val2 -> Value in return val1 })
                return
            }
        }
        return nil
    }
}
