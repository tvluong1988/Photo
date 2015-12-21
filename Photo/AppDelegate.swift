//
//  AppDelegate.swift
//  Photo
//
//  Created by Thinh Luong on 12/20/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import UIKit
import Parse

/**
 *  Parse API information
 */
struct ParseAPI {
  static let applicationId = "0BrfDmIJfLMETuzfgRLytEbku1DNmzTYGUB6a0JI"
  static let clientKey     = "B1RZIUcsgtKk3LwPeNcVEapm3GifqwFiiln54Ttq"
  static let className     = "Cat"
  
  /**
   *  Cat schema
   */
  struct Schema {
    static let name  = "name"
    static let votes = "votes"
    static let cc_by = "cc_by"
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Parse.setApplicationId(ParseAPI.applicationId, clientKey: ParseAPI.clientKey)
    
    let tableVC = CatsTableViewController(className: ParseAPI.className)
    tableVC.title = "\(ParseAPI.className)s"
    
    let appearance = UINavigationBar.appearance()
    appearance.tintColor = UIColor.blueColor()
    appearance.barTintColor = UIColor.darkGrayColor()
    appearance.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    
    let navigationVC = UINavigationController(rootViewController: tableVC)
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    window!.rootViewController = navigationVC
    window!.makeKeyAndVisible()
    
    
    return true
  }
}




















