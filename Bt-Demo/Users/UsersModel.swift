//
//  UsersModel.swift
//  Bt-Demo
//
//  Created by Ronak Malick on 02/02/24.
//

import Foundation

class UsersModel {
    private let task: UserNetworkTask
    private var tempUser: [User] = []
    private var maxPages: UInt = 1

    init(task: UserNetworkTask = UserNetworkTask()) {
        self.task = task
    }

    func fetch(page: UInt, onCompletion: @escaping (Result<[User]?, UserError>) -> (Void)) {
        guard page <= maxPages else {
            onCompletion(.failure(.maxPageCountReached))
            return
        }
        guard let url = generateURL(page: page) else {
            onCompletion(.failure(.urlNotValid))
            return
        }
        task.fetch(url: url) { [weak self] result in
            switch result {
            case .success(let user):
                self?.maxPages = user.totalPages
                self?.tempUser.append(contentsOf: user.data)
                onCompletion(.success(self?.tempUser))
            case .failure(let err):
                onCompletion(.failure(err))
            }
        }
    }
    
    private func generateURL(page: UInt) -> URL? {
        let urlString = "https://reqres.in/api/users?page=\(page)"
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
}
