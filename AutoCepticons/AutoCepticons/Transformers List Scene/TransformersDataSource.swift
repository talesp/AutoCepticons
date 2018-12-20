//
//  TransformersDataSource.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 15/12/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import CoreData
class TransformersDataSource: NSObject {

    var didSelect: ((Transformer) -> Void)?

    private var fetchedResultsController: NSFetchedResultsController<Transformer>!

    private(set) var transformers: [Transformer] = []

    weak var tableView: UITableView?
    private var persistencyStack: PersistencyStack

    func setupFetchedResultsController() {
        guard let fetchRequest = Transformer.fetchRequest() as? NSFetchRequest<Transformer> else {
            fatalError("Bad fetch request")
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: self.persistencyStack.viewContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: "transformers")
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }

    init(tableView: UITableView, persistencyStack: PersistencyStack) {
        self.tableView = tableView
        self.persistencyStack = persistencyStack
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.estimatedRowHeight = 160
        self.tableView?.registerReusable(cellType: TransformersListTableViewCell.self)
        setupFetchedResultsController()
    }

    func updateDatasource(transformers: [Transformer]) {
        self.transformers = transformers
        #warning("update or insert new data")
    }

    func deleteItem(at indexPath: IndexPath) {
        let item = fetchedResultsController.object(at: indexPath)
        persistencyStack.viewContext.delete(item)
        try? persistencyStack.viewContext.save()
    }
}

extension TransformersDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransformersListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let transformer = fetchedResultsController.object(at: indexPath)
        cell.setup(transformer: transformer)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteItem(at: indexPath)
        default:
            break
        }
    }
}

extension TransformersDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transformer = fetchedResultsController.object(at: indexPath)
        self.didSelect?(transformer)
    }
}


extension TransformersDataSource: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView?.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            tableView?.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            tableView?.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView?.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView?.insertSections(indexSet, with: .fade)
        case .delete:
            tableView?.deleteSections(indexSet, with: .fade)
        case .update, .move:
            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
        }
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView?.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView?.endUpdates()
    }
}
