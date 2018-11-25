//
//  UserDefaults.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/25/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

extension UserDefaults {
    static var allSpark: String? {
        get {
            return self.standard.value(forKey: "AllSpark") as? String
        }
        set {
            self.standard.set(newValue, forKey: "AllSpark")
        }
    }
}
