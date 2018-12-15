//
//  TransformerViewController.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 09/12/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TransformerViewController: UIViewController {

    private let transformer: Transformer? = nil
    private let transformerView: TransformerView

    init(transformer: Transformer?) {
        self.transformerView = TransformerView(model: transformer)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = TransformerView(model: transformer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let transformer = transformer else {
            title = "Create new Transformer"
            return
        }
        title = transformer.name
    }
}
