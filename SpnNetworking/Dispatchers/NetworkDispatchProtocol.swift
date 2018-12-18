//
//  NetworkDispatchProtocol.swift
//  SpnNetworking
//
//  Created by Rahmi on 1.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

public typealias NetworkDispatchCompletion = (Data?, URLResponse?, Error?) -> Void

public protocol NetworkDispatchType: AnyObject {
    func execute(urlRequest: URLRequest, completion: @escaping NetworkDispatchCompletion) -> URLSessionTask?
}
