//
//  TransformersViewController.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/25/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TransformersViewController: UIViewController {

    private lazy var transformersView = TransformersView(frame: .zero)

    override func loadView() {
        self.view = transformersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
