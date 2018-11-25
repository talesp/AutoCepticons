//
//  StringDecoder.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/25/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class StringDecoder: DecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        precondition(T.self == String.self)
        guard let string = String(bytes: data, encoding: .utf8) else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: [], debugDescription: "Expected String, got something else"))
        }
        return string as! T
    }
}
