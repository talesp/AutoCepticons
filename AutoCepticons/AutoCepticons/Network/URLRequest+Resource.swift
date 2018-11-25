//
//  URLRequest+Resource.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

extension URLRequest {
    init<A>(resource: Resource<A>) {
        self.init(url: resource.url)
        httpMethod = resource.method.method
        if case let .post(data) = resource.method {
            httpBody = data
        }
    }
}
