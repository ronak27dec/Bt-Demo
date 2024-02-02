//
//  NetworkService.swift
//  Bt-Demo
//
//  Created by Ronak Malick on 02/02/24.
//

import Foundation

class UserNetworkTask {
    func fetch(url: URL, onCompletion: @escaping (Users) -> (Void)) {
        let req = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: req) { data, resp, err in
            guard let unwrappedData = data else { return }
            do {
                let decoder = JSONDecoder()
                let unwrapedModel = try decoder.decode(Users.self, from: unwrappedData)
                print(unwrapedModel)
                onCompletion(unwrapedModel)
            } catch {
                print("parser failure \(error)")
            }
        }.resume()
    }
}
