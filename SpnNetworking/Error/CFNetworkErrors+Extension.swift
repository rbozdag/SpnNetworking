//
//  CFNetworkErrors+Extension.swift
//  SpnNetworking
//
//  Created by Rahmi on 1.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

public extension CFNetworkErrors {
    public init?(_ error: Error) {
        let errorCode = (error as NSError).code
        if let cfNetworkError = CFNetworkErrors.init(rawValue: Int32(errorCode)) {
            self = cfNetworkError
        }
        return nil
    }
}
