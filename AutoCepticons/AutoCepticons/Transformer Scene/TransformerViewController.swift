//
//  TransformerViewController.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 09/12/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TransformerViewController: UIViewController {

    private let transformer: Transformer?
    private let transformerView: TransformerView
    private let webservice: Webservice
    private let persistencyStack: PersistencyStack

    private func insertOrUpdateTransformer(values: TransformerView.TransformerAttributes) {
        let transformer: Transformer
        if let transf = self.transformer {
            transf.name = values.name
            transf.team = values.team
            transf.strength = values.strength
            transf.intelligence = values.intelligence
            transf.speed = values.speed
            transf.endurance = values.endurance
            transf.rank = values.rank
            transf.courage = values.courage
            transf.firepower = values.firepower
            transf.skill = values.skill
            transformer = transf

        } else {
            transformer = Transformer(name: values.name,
                                      team: values.team,
                                      strength: values.strength,
                                      intelligence: values.intelligence,
                                      speed: values.speed,
                                      endurance: values.endurance,
                                      rank: values.rank,
                                      courage: values.courage,
                                      firepower: values.firepower,
                                      skill: values.skill,
                                      managedObjectContext: self.persistencyStack.viewContext
            )
        }

        do {
            try self.persistencyStack.viewContext.save()
        }
        catch {
            fatalError(error.localizedDescription)
        }

        let resource: Resource<Transformer>
        if transformer.id != nil {
            resource = transformer.put()
        }
        else {
            resource = transformer.post()
        }
        let transformerID = transformer.objectID
        let backgroundContext = self.persistencyStack.backgroundContext
        webservice.load(resource) { result in
            switch result {
            case .success(let transformer):
                guard let url = transformer.teamIconURL else {
                    print("fuem")
                    return
                }

                URLSession(configuration: .default).dataTask(with: url, completionHandler: { data, response, error in
                    guard let data = data else { return }
                    self.persistencyStack.backgroundContext.perform {
                        guard let transformer = backgroundContext.object(with: transformerID) as? Transformer else { return }
                        transformer.teamIcon = data
                        do {
                            try backgroundContext.save()
                        }
                        catch {
                            fatalError(error.localizedDescription)
                        }
                    }

                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        guard let image = image else { return }
                        self.transformerView.iconImageView.image = image
                    }
                }).resume()
            case .failure(let error):
                dump(error)
            }
        }
    }

    init(persistencyStack: PersistencyStack,
         transformer: Transformer?,
         webservice: Webservice = Webservice(urlSession: URLSession(configuration: .default))) {
        self.persistencyStack = persistencyStack
        self.transformer = transformer
        self.webservice = webservice
        self.transformerView = TransformerView(model: transformer)
        super.init(nibName: nil, bundle: nil)

        self.transformerView.updatedValues = self.insertOrUpdateTransformer
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = self.transformerView
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
