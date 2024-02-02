//
//  NetworkError.swift
//  Bt-Demo
//
//  Created by Ronak Malick on 03/02/24.
//

import Foundation

enum UserError: Error {
    case genericError
    case urlNotValid
    case parsingFailed
    case noData
    case maxPageCountReached
}
