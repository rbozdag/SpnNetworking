//
//  NsUrlSessionNetworkDispatcher.swift
//  SpnNetworking
//
//  Created by Rahmi on 2.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

class UrlSessionNetworkDispatch: NetworkDispatchType {
    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }
    
    func execute(urlRequest: URLRequest, completion: @escaping NetworkDispatchCompletion) -> URLSessionTask? {
        let task = session.dataTask(with: urlRequest, completionHandler: completion)
        return task
    }
}
