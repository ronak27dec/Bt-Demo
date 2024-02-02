//
//  UsersModelTest.swift
//  Bt-DemoTests
//
//  Created by Ronak Malick on 03/02/24.
//

import XCTest
@testable import Bt_Demo

final class UsersModelTest: XCTestCase {
    private var sut: UsersModel!
    
    override func setUp() {
        sut = UsersModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testFetch_SUCCESS() {
        let mockUser = Users(page: 1,
                             totalPages: 2,
                             perPage: 3,
                             total: 6,
                             data: [User(id: 1,
                                         email: "test@test.com",
                                         firstName: "test-firstname",
                                         lastName: "test-lastname",
                                         avatar: "avatar-test")])
        let mockTask = MockUserNetworkTask(result: .success(mockUser))
        let usersModel = UsersModel(task: mockTask)
        let expectation = XCTestExpectation(description: "Fetch completion")

        usersModel.fetch(page: 1) { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users?.count, 1)
                XCTAssertEqual(users?.first?.firstName, "test-firstname")
                XCTAssertEqual(users?.first?.lastName, "test-lastname")
                XCTAssertEqual(users?.first?.email, "test@test.com")
                XCTAssertNotNil(users?.first?.avatar, "avatar-test")
            case .failure:
                XCTFail("Expected success, but got failure.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetch_MaxPageCountReached_FAILURE() {
            let mockTask = MockUserNetworkTask(result: .failure(.maxPageCountReached))
            let usersModel = UsersModel(task: mockTask)
            let expectation = XCTestExpectation(description: "Fetch completion")

            usersModel.fetch(page: 2) { result in
                switch result {
                case .success:
                    XCTFail("Expected failure, but got success.")
                case .failure(let error):
                    XCTAssertEqual(error, .maxPageCountReached)
                }
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0)
        }
}
