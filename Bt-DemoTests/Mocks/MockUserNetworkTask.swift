//
//  MockUserNetworkTask.swift
//  Bt-DemoTests
//
//  Created by Ronak Malick on 03/02/24.
//

import Foundation
@testable import Bt_Demo

class MockUserNetworkTask: UserNetworkTask {
    var result: Result<Users, UserError>

    init(result: Result<Users, UserError>) {
        self.result = result
    }

    override func fetch(session: URLSession = MockURLSession(data: nil, response: nil, error: nil),
                        url: URL,
                        onCompletion: @escaping (Result<Users, UserError>) -> (Void)) {
        onCompletion(result)
    }
}
