//
//  AppDelegate.swift
//  VersionsDemo
//
//  Created by Christoffer Winterkvist on 20/05/15.
//
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    println(App.version)
    return true
  }
}

