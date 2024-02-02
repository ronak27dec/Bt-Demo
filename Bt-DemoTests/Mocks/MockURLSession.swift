//
//  MockURLSession.swift
//  Bt-DemoTests
//
//  Created by Ronak Malick on 03/02/24.
//

import Foundation

class MockURLSession: URLSession {
    var mockDataTask: MockURLSessionDataTask

    init(data: Data?,
         response: URLResponse?,
         error: Error?) {
        mockDataTask = MockURLSessionDataTask(data: data,
                                              response: response,
                                              error: error)
    }

    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        mockDataTask.completionHandler = completionHandler
        return mockDataTask
    }
}
