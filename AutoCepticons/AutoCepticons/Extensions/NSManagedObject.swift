//
//  NSManagedObject.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 17/12/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    static var entityName: String {
        return String(describing: self)
    }
}
