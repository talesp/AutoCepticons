//
//  AppDelegate.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/23/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootViewController: UINavigationController?

    private lazy var persistencyStack: PersistencyStack = {
        return PersistencyStack(modelName: PersistencyStack.modelName)
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow()

        self.persistencyStack.load()

        if UserDefaults.allSpark != nil {
            let viewController = TransformersViewController(persistencyStack: self.persistencyStack)
            rootViewController = UINavigationController(rootViewController: viewController)
            
        }
        else {
            let viewController = AllSparkLoaderViewController(persistencyStack: self.persistencyStack)
            rootViewController = UINavigationController(rootViewController: viewController)
            rootViewController?.isNavigationBarHidden = true
        }
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveViewContext()
    }

    func saveViewContext() {
        try? persistencyStack.viewContext.save()
    }
}
