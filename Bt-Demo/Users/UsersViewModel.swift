//
//  UsersViewModel.swift
//  Bt-Demo
//
//  Created by Ronak Malick on 02/02/24.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var user: [User] = []
    private let pageCount: UInt = 1

    private var model: UsersModel
    
    init(model: UsersModel = UsersModel()) {
        self.model = model
    }

    func fetchUsers(pageCount: UInt) {
        model.fetch(pageCount: pageCount) { [weak self] user in
            DispatchQueue.main.async {
                self?.user = user ?? []
            }
        }
    }
}
