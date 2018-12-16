//
//  TransformersDataSource.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 15/12/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TransformersDataSource: NSObject, UITableViewDataSource {

    private(set) var transformers: [Transformer] = []

    weak var tableView: UITableView?

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.estimatedRowHeight = 160
        self.tableView?.registerReusable(cellType: TransformersListTableViewCell.self)
    }

    func updateDatasource(transformers: [Transformer]) {
        self.transformers = transformers
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transformers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransformersListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(transformer: transformers[indexPath.row])
        return cell
    }

}
