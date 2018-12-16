//
//  TransformersList+Resource.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

extension TransformersList {
    static private let pathURLString = "transformers"
    static private let baseURL = TransformersAPIConfig.baseURL

    static func resource() -> Resource<TransformersList> {
        let url = self.baseURL.appendingPathComponent(self.pathURLString)

        let headers: [HTTPHeader] = [.contentType("application/json"), .authorization("Bearer \(UserDefaults.allSpark!)")]
        return Resource(url: url, method: .get, headers: headers)
    }
}
