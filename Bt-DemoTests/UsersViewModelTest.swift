//
//  UsersViewModelTest.swift
//  Bt-DemoTests
//
//  Created by Ronak Malick on 03/02/24.
//

import XCTest
@testable import Bt_Demo

final class UsersViewModelTest: XCTestCase {
    private var sut: UsersViewModel!
    
    override func setUp() {
        sut = UsersViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testFetchUsers_SUCCESS() {
        let mockUser = Users(page: 1,
                             totalPages: 2,
                             perPage: 3,
                             total: 6,
                             data: [User(id: 1,
                                         email: "test@test.com",
                                         firstName: "test-firstname",
                                         lastName: "test-lastname",
                                         avatar: "avatar-test")])
        let mockModel = MockUsersModel(result: .success(mockUser.data))
        let usersViewModel = UsersViewModel(model: mockModel)
        let expectation = XCTestExpectation(description: "Fetch users completion")
        
        usersViewModel.fetchUsers(page: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(usersViewModel.user.count, 1)
            XCTAssertEqual(usersViewModel.user.first?.firstName, "test-firstname")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchUsers_FAILURE() {
            let mockModel = MockUsersModel(result: .failure(.genericError))
            let usersViewModel = UsersViewModel(model: mockModel)
            let expectation = XCTestExpectation(description: "Fetch users completion")

            usersViewModel.fetchUsers(page: 1)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                XCTAssertEqual(usersViewModel.user.count, 0)
                XCTAssertEqual(usersViewModel.error, .genericError)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 5.0)
        }
}
