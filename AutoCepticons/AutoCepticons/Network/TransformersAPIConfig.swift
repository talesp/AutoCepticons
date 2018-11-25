//
//  TransformersAPIConfig.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct TransformersAPIConfig {
    static let baseURLString = "https://transformers-api.firebaseapp.com/"
    static let baseURL = URL(string: TransformersAPIConfig.baseURLString) !! "Verify the address for base URL"
}
