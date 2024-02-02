//
//  User.swift
//  Bt-Demo
//
//  Created by Ronak Malick on 02/02/24.
//

import Foundation

struct User: Codable {
    var id: UInt
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
    }
    
}
