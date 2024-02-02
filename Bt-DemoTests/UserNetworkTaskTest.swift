//
//  UserNetworkTaskTest.swift
//  Bt-DemoTests
//
//  Created by Ronak Malick on 03/02/24.
//

import XCTest
@testable import Bt_Demo

final class UserNetworkTaskTest: XCTestCase {
    private var sut: UserNetworkTask!
    private var mockSession: MockURLSession!
    
    override func setUp() {
        sut = UserNetworkTask()
        mockSession = MockURLSession(data: nil, response: nil, error: nil)
    }
    
    override func tearDown() {
        mockSession = nil
        sut = nil
    }
    
    func testFetch_SUCCESS() {
        let mockData = """
                {"page":1,"per_page":6,"total":12,"total_pages":2,"data":[{"id":1,"email":"george.bluth@reqres.in","first_name":"George","last_name":"Bluth","avatar":"https://reqres.in/img/faces/1-image.jpg"}],"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
            
            """.data(using: .utf8)!
        
        let url = URL(string: "https://example.com")!
        let mockSession = MockURLSession(data: mockData, response: nil, error: nil)
        let expectation = XCTestExpectation(description: "Fetch completion")
        
        sut.fetch(session: mockSession, url: url) { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.data.count, 1)
                XCTAssertEqual(users.data.first?.firstName, "George")
                XCTAssertEqual(users.data.first?.lastName, "Bluth")
                XCTAssertEqual(users.data.first?.email, "george.bluth@reqres.in")
                XCTAssertNotNil(users.data.first?.avatar)
            case .failure:
                XCTFail("Expected success, but got failure.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetch_NoData_FAILURE() {
        let url = URL(string: "https://example.com")!
        let mockSession = MockURLSession(data: nil, response: nil, error: nil)
        let expectation = XCTestExpectation(description: "Fetch completion")
        
        sut.fetch(session: mockSession, url: url) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success.")
            case .failure(let error):
                XCTAssertEqual(error, .noData)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
