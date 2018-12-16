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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow()

        if UserDefaults.allSpark != nil {
            rootViewController = UINavigationController(rootViewController: TransformersViewController())
            
        }
        else {
            rootViewController = UINavigationController(rootViewController: AllSparkLoaderViewController())
            rootViewController?.isNavigationBarHidden = true
        }
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }

}
