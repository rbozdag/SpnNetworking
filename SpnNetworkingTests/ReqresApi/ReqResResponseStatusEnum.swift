//
//  ReqResResponseStatusEnum.swift
//  SpnNetworkingTests
//
//  Created by Rahmi on 19.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

@testable import SpnNetworking

enum ReqResResponseStatusEnum: Int {
    case successStatus
    case warningStatus
    case errorStatus
    case unknownStatus
}

extension ReqResResponseStatusEnum {
    static func toStatusType(httpStatusCode: HTTPStatusCode?) -> ReqResResponseStatusEnum {
        guard let httpStatusCode = httpStatusCode?.rawValue else {
            return .unknownStatus
        }
        
        switch httpStatusCode {
        case 428:
            fallthrough
        case 200 ..< 300:
            return .successStatus
        case 300 ..< 400:
            return .warningStatus
        case 400 ..< 600:
            return .errorStatus
        default:
            return .unknownStatus
        }
    }
}

