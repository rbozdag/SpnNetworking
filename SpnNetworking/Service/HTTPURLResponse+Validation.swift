//
//  URLResponse+Validation.swift
//  SpnNetworking
//
//  Created by Rahmi on 11.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

public extension HTTPURLResponse {
    var responseContentType: MimeTypeEnum? {
        guard let responseContentTypeStr = allHeaderFields[HTTPHeaderKeyEnum.contentType.rawValue] as? String else {
            return nil
        }
        return MimeTypeEnum(rawValue: String(responseContentTypeStr.split(separator: ";").first!))
    }

    var responseContentTypeStr: String? {
        guard let responseContentTypeStr = allHeaderFields[HTTPHeaderKeyEnum.contentType.rawValue] as? String else {
            return nil
        }
        return responseContentTypeStr
    }

    public func isValidContentType(expected: MimeTypeEnum) -> Bool {
        guard let responseContentTypeStr = self.responseContentTypeStr else {
            return false
        }
        return responseContentTypeStr.contains(expected.rawValue)
    }
}
