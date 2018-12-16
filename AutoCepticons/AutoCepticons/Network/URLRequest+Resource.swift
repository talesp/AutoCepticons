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
        for header in resource.headers {
            switch header {
            case .accept(let accept):
                setValue(accept, forHTTPHeaderField: "Accept")
            case .authorization(let token):
                setValue(token, forHTTPHeaderField: "Authorization")
            case .contentType(let contentType):
                setValue(contentType, forHTTPHeaderField: "Content-Type")
            }
        }
        if case let .post(data) = resource.method {
            httpBody = data
        }
    }
}
