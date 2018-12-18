//
//  Reqres.swift
//  SpnNetworkingTests
//
//  Created by Rahmi on 19.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation

struct ReqresUsers: Codable {
    let page, perPage, total, totalPages: Int
    let data: [ReqresUser]
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
    }
}

struct ReqresUser: Codable {
    let id: Int
    let firstName, lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
