//
//  HTTPMethod.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

enum HTTPMethod<Body> {
    case get
    case post(Body)
    case put(Body)
    case delete
}

extension HTTPMethod {
    var method: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }

    func map<B>(function: (Body) -> B) -> HTTPMethod<B> {
        switch self {
        case .get:
            return .get
        case .post(let body):
            return .post(function(body))
        case .put(let body):
            return .put(function(body))
        case .delete:
            return .delete
        }

    }
}
