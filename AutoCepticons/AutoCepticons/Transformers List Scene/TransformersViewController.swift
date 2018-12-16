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

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(createTransformer(sender:)))
        self.navigationItem.setRightBarButton(rightButtonItem, animated: true)

        let leftButtonItem = UIBarButtonItem(title: "Go to War",
                                             style: UIBarButtonItem.Style.plain,
                                             target: self,
                                             action: #selector(fightTransformers(sender:)))
        self.navigationItem.setLeftBarButton(leftButtonItem, animated: true)
        datasource.tableView?.backgroundView = datasource.transformers.count == 0 ? TransformersEmptyView() : nil
        self.webservice.load(TransformersList.resource()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.datasource.updateDatasource(transformers: response.transformers)
                    UIView.animate(withDuration: 0.25, animations: {
                        self.datasource.tableView?.backgroundView?.alpha = 0
                    }, completion: { didFinished in
                        self.datasource.tableView?.backgroundView = nil
                    })
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }

    @objc
    func createTransformer(sender: Any) {
        self.show(TransformerViewController(transformer: nil), sender: self)
    }

    private func whoIsTheBravest(_ autobot: Transformer, decepticon: Transformer) -> TransformerTeam? {
        precondition(autobot.team == .autobot, "First transformer should be an Autobot")
        precondition(decepticon.team == .decepticon, "Second Transformer should be a Decepticon")

        if autobot.courage - decepticon.courage > 4 && autobot.strength - decepticon.strength > 3 {
            return .autobot
        }
        else if decepticon.courage - autobot.courage > 4 && decepticon.strength - autobot.strength > 3 {
            return .decepticon
        }

        return nil
    }

    private func whoIsTheSkillest(_ autobot: Transformer, decepticon: Transformer) -> TransformerTeam? {
        if autobot.skill - decepticon.skill >= 3 {
            return .autobot
        }
        else if decepticon.skill - autobot.skill >= 3 {
            return .decepticon
        }

        return nil

    }


    @objc
    func fightTransformers(sender: Any) {
        let transformers = self.datasource.transformers
        let autobots = transformers.filter({ $0.team == .autobot}).sorted(by: { $0.rank > $1.rank })
        let decepticons = transformers.filter({ $0.team == .decepticon }).sorted(by: { $0.rank > $1.rank })

        let fighters = zip(autobots, decepticons)

        let winners: [TransformerTeam] = fighters.compactMap { duelings in
            let (autobot, decepticon) = duelings

            if autobot.name == "Optimus Prime" || autobot.name == "Predaking" {
                return .autobot
            }

            if decepticon.name == "Optimus Prime" || decepticon.name == "Predaking" {
                return .decepticon
            }

            if let bravest = whoIsTheBravest(autobot, decepticon: decepticon) {
                return bravest
            }

            if let skillest = whoIsTheSkillest(autobot, decepticon: decepticon) {
                return skillest
            }

            if autobot.overallRating > decepticon.overallRating {
                return .autobot
            }
            else if decepticon.overallRating > autobot.overallRating {
                return .decepticon
            }

            return nil
        }


//        let controller = UIAlertController(title: "Transformers War",
//                                           message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
    }
}
