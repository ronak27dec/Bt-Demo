//
//  UsersModel.swift
//  Bt-Demo
//
//  Created by Ronak Malick on 02/02/24.
//

import Foundation

class UsersModel {
    private let service: NetworkService
    private var tempUser: [User] = []
    private var maxPages: UInt = 1

    init(service: NetworkService = NetworkService()) {
        self.service = service
    }

    func fetch(pageCount: UInt, onCompletion: @escaping ([User]?) -> (Void)) {
        guard pageCount <= maxPages else { return }
        guard let url = generateURL(pageCount: pageCount) else { return }
        service.fetch(url: url) { [weak self] user in
            self?.maxPages = user.totalPages
            self?.tempUser.append(contentsOf: user.data)
            onCompletion(self?.tempUser)
        }
    }
    
    private func generateURL(pageCount: UInt) -> URL? {
        let urlString = "https://reqres.in/api/users?page=\(pageCount)"
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
}
