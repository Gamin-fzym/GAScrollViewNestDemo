//
//  AppDelegate.swift
//  GAScrollViewNestDemo
//
//  Created by MaciOS on 2022/5/5.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let home = GAHomeVC()
        let nav = UINavigationController(rootViewController: home)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

}

