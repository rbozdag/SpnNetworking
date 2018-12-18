//
//  ReqresError.swift
//  SpnNetworkingTests
//
//  Created by Rahmi on 19.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation
@testable import SpnNetworking

struct ReqresError: NetworkErrorType, Codable {
    init(with error: NetworkErrorEnum, httpStatus: HTTPStatusCode?) {
        self.error = error.localizedDescription
    }
    
    let error: String
}
