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

    private lazy var webservice = Webservice()
    private lazy var log = OSLog(subsystem: "com.talesp.autocepticons", category: "allspark")

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
                let viewController = UIViewController()
                viewController.modalTransitionStyle = .crossDissolve
                viewController.view.backgroundColor = .orange
                self.navigationController?.setToolbarHidden(false, animated: true)
                self.show(viewController, sender: self)

            case .failure(let error):
                os_log(OSLogType.debug, log: self.log, "error getting allspark: %{private}@", error.localizedDescription)
            }
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .cyan
        }
    }

}

