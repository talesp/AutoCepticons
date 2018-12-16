//
//  Reusable.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 15/12/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func registerReusable<T: UITableViewCell>(cellType: T.Type, forCellReuseIdentifier identifier: String = T.reuseIdentifier) where T: Reusable {
        self.register(cellType.self, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath, celltype: T.Type = T.self) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: celltype.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Register cell type \(celltype.self)")
        }
        return cell
    }
}
