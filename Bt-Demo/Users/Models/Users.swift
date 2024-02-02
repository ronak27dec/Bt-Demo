//
//  Users.swift
//  Bt-Demo
//
//  Created by Ronak Malick on 02/02/24.
//

import Foundation

struct Users: Codable {
    var page: UInt
    var totalPages: UInt
    var perPage: UInt
    var total: UInt
    var data: [User]
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPages = "total_pages"
        case perPage = "per_page"
        case total = "total"
        case data = "data"
    }
}
