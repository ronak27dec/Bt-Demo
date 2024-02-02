//
//  MockUsersModel.swift
//  Bt-DemoTests
//
//  Created by Ronak Malick on 03/02/24.
//

import Foundation
@testable import Bt_Demo

class MockUsersModel: UsersModel {
    var result: Result<[User]?, UserError>

    init(result: Result<[User]?, UserError>) {
        self.result = result
        super.init()
    }

    override func fetch(page: UInt,
                        onCompletion: @escaping (Result<[User]?, UserError>) -> Void) {
        onCompletion(result)
    }
}
