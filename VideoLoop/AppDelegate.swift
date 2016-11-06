//
//  AppDelegate.swift
//  VideoLoop
//
//  Created by Pi on 11/5/16.
//  Copyright © 2016 Pi Dynamics. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  public let viewController = ViewController()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window!.rootViewController = viewController
    self.window!.backgroundColor = UIColor.white
    self.window!.makeKeyAndVisible()
    return true
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    viewController.pauseVideo()
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    viewController.playVideo()
  }

}
