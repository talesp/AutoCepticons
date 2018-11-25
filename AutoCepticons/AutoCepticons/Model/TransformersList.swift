//
//  TransformersList.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class TransformersList: Codable {
    let transformers: [Transformer]

    enum CodingKeys: String, CodingKey {
        case transformers = "transformers"
    }

    init(transformers: [Transformer]) {
        self.transformers = transformers
    }
}
