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

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window!.rootViewController = viewController
    self.window!.backgroundColor = UIColor.white
    self.window!.makeKeyAndVisible()
    return true
  }
  
  @nonobjc func applicationWillResignActive(application: UIApplication) {  }
  
  @nonobjc func applicationDidEnterBackground(application: UIApplication) {
    viewController.pauseVideo()
  }
  
  @nonobjc func applicationWillEnterForeground(application: UIApplication) {
    viewController.playVideo()
  }
  
  @nonobjc func applicationDidBecomeActive(application: UIApplication) { }
  
  @nonobjc func applicationWillTerminate(application: UIApplication) { }

}

