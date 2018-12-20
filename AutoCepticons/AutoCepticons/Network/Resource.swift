//
//  Resource.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import CoreData

enum HTTPHeader {
    case contentType(String)
    case accept(String)
    case authorization(String)
}

struct Resource<T: Codable> {
    let url: URL
    let method: HTTPMethod<Data>
    let headers: [HTTPHeader]
    let parse: (Data) throws -> T
}

extension JSONDecoder {
    convenience init(managedObjectContext: NSManagedObjectContext) {
        self.init()
        if let key = CodingUserInfoKey.managedObjectContext {
            self.userInfo[key] = managedObjectContext
        }
    }
}
extension Resource {

    init(url: URL,
         method: HTTPMethod<T> = .get,
         headers: [HTTPHeader],
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
        self.headers = headers
        self.parse = { data in
            return try decoder.decode(T.self, from: data)
        }
    }
}
