//
//  Resource.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
    let method: HTTPMethod<Data>
    let parse: (Data) throws -> T
}

extension Resource {

    init(url: URL,
         method: HTTPMethod<T> = .get,
         decoder: DecoderProtocol = JSONDecoder(),
         encoder: JSONEncoder = JSONEncoder()) {
        self.url = url
        self.method = method.map { json in
            do {
                return try encoder.encode(json)
            }
            catch {
                fatalError(error.localizedDescription)
            }
        }
        self.parse = { data in
            return try decoder.decode(T.self, from: data)
        }
    }
}
