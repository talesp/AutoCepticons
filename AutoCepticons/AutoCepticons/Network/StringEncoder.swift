//
//  StringEncoder.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/25/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class StringEncoder: JSONEncoder {
    override func encode<T>(_ value: T) throws -> Data where T : Encodable, T : StringProtocol {

        guard let string = value as? String,
            let data =  string.data(using: .utf8) else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [], debugDescription: "Could not convert [value] into a Data type"))
        }
        return data
    }
}
