//
//  AllSparkLoaderViewController.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/23/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import os

class AllSparkLoaderViewController: UIViewController {

    private let webservice: Webservice
    private lazy var log = OSLog(subsystem: "com.talesp.autocepticons", category: "allspark")

    init(webservice: Webservice = Webservice()) {
        self.webservice = webservice
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = AllSparkLoaderView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _ = webservice.load(Transformer.allSparkResource) { [unowned self] result in
            switch result {
            case .success(let allspark):
                os_log(OSLogType.debug, log: self.log, "got allspark: %{private}s", allspark)
                UserDefaults.allSpark = allspark
                let viewController = TransformersViewController()
                viewController.modalTransitionStyle = .crossDissolve
                DispatchQueue.main.async {
                    self.show(viewController, sender: self)
                }

            case .failure(let error):
                os_log(OSLogType.debug,
                       log: self.log, "error getting allspark: %{private}@", error.localizedDescription)
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(action)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .cyan
        }
    }

}

