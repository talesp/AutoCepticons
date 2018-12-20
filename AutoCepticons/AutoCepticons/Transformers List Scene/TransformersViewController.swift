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
    private let persistencyStack: PersistencyStack

    init(persistencyStack: PersistencyStack, webservice: Webservice = Webservice(urlSession: URLSession(configuration: .default))) {
        self.persistencyStack = persistencyStack
        self.webservice = webservice
        datasource = TransformersDataSource(tableView: self.transformersView.tableView,
                                            persistencyStack: persistencyStack) 
        super.init(nibName: nil, bundle: nil)

        datasource.didSelect = { [weak self] transformer in
            guard let self = self else { return }
            self.show(TransformerViewController(persistencyStack: persistencyStack, transformer: transformer),
                      sender: self)
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
//        self.webservice.load(TransformersList.resource()) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let response):
//                DispatchQueue.main.async {
//                    self.datasource.updateDatasource(transformers: response.transformers)
//                    UIView.animate(withDuration: 0.25, animations: {
//                        self.datasource.tableView?.backgroundView?.alpha = 0
//                    }, completion: { didFinished in
//                        self.datasource.tableView?.backgroundView = nil
//                    })
//                }
//            case .failure(let error):
//                fatalError(error.localizedDescription)
//            }
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let tableView = self.datasource.tableView,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.reloadRows(at: [indexPath], with: .fade)

    }
    @objc
    func createTransformer(sender: Any) {
        self.show(TransformerViewController(persistencyStack: persistencyStack, transformer: nil), sender: self)
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
        let autobots = transformers.filter({ $0.team == .autobot}).sorted(by: {
            if $0.name == "Optimus Prime" || $0.name == "Predaking" {
                return true
            }
            return $0.rank > $1.rank
        })
        let decepticons = transformers.filter({ $0.team == .decepticon }).sorted(by: {
            if $0.name == "Optimus Prime" || $0.name == "Predaking" {
                return true
            }
            return $0.rank > $1.rank
        })

        let sparedTransformers: [String]
        let numberOfBattles: Int
        if autobots.count > decepticons.count {
            sparedTransformers = Array(autobots.dropFirst(decepticons.count)).map({ $0.name })
            numberOfBattles = decepticons.count
        }
        else if autobots.count < decepticons.count {
            sparedTransformers = Array(decepticons.dropFirst(autobots.count)).map({ $0.name })
            numberOfBattles = autobots.count
        }
        else {
            numberOfBattles = autobots.count
            sparedTransformers = []
        }
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

        var message: String

        if winners.count == 0 {
            message = "Impossible to go to War. Add more Transformers"
        }
        else {
            let matchesWon = winners.reduce(into: [TransformerTeam: Int]()) {
                return $0[$1, default: 0] += 1
            }

            let noTransformerLeftMessage = "No Transformer was left behind."
            if matchesWon[.autobot, default: 0] > matchesWon[.decepticon, default: 0] {
                message = """
                Number of battles: \(numberOfBattles)
                Winner Team: Autobots: \(autobots[..<(min(autobots.count, decepticons.count))].map({ $0.name }).joined(separator: ", ")).
                \(sparedTransformers.count > 0 ? "Survivors from the losing team: \(sparedTransformers.joined(separator: ", "))" : "\(noTransformerLeftMessage)")
                """
            }
            else if matchesWon[.decepticon, default: 0] > matchesWon[.autobot, default: 0] {
                message = """
                Number of battles: \(numberOfBattles)
                Winner Team: Decepticons: \(decepticons[..<(min(autobots.count, decepticons.count))].map({ $0.name }).joined(separator: ", ")).
                \(sparedTransformers.count > 0 ? "Survivors from the losing team: \(sparedTransformers.joined(separator: ", "))" : "\(noTransformerLeftMessage)")
                """
            }
            else {
                message = "It's a draw. All Transformers destroyed."
            }

        }

        let controller = UIAlertController(title: "Transformers War",
                                           message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        controller.addAction(action)
        self.present(controller, animated: true)
    }
}
