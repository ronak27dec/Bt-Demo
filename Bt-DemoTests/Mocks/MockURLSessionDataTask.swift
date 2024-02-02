//
//  MockURLSessionDataTask.swift
//  Bt-DemoTests
//
//  Created by Ronak Malick on 03/02/24.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    private let data: Data?
    private let resp: URLResponse?
    private let err: Error?
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    init(data: Data?,
         response: URLResponse?,
         error: Error?) {
        self.data = data
        self.resp = response
        self.err = error
    }

    override func resume() {
        completionHandler?(data, response, error)
    }
}
