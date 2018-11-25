//
//  DecoderProtocol.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/25/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol DecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: DecoderProtocol {}
