//
//  UsersViewModel.swift
//  Bt-Demo
//
//  Created by Ronak Malick on 02/02/24.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var user: [User] = []
    @Published var error: UserError = .genericError

    private let page: UInt = 1
    private var model: UsersModel
    
    init(model: UsersModel = UsersModel()) {
        self.model = model
    }

    func fetchUsers(page: UInt) {
        model.fetch(page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.user = user ?? []
                    
                case .failure(let err):
                    self?.error = err
                }
            }
        }
    }
}
