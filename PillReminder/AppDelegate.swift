//
//  AppDelegate.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/17/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  let vc = ViewController()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground

    let navController = UINavigationController(rootViewController: vc)
    window?.rootViewController = navController
    return true
  }

}


