//
//  TransformersViewController.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/25/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TransformersViewController: UIViewController {

    private let transformersView = TransformersView(frame: .zero)
    private let webservice: Webservice
    private let datasource: TransformersDataSource

    init(webservice: Webservice = Webservice(urlSession: URLSession(configuration: .default))) {
        self.webservice = webservice
        datasource = TransformersDataSource(tableView: self.transformersView.tableView) 
        super.init(nibName: nil, bundle: nil)

        datasource.didSelect = { [weak self] transformer in
            guard let self = self else { return }
            self.show(TransformerViewController(transformer: transformer), sender: self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = transformersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AutoBots or Decepticon?"

        self.webservice.load(TransformersList.resource()) { result in
            switch result {
            case .success(let response):
                self.datasource.updateDatasource(transformers: response.transformers)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }

}
