//
//  AppDelegate.swift
//  CustomAuth
//
//  Created by Dennis Hills on 12/4/19.
//  Copyright © 2019 Dennis Hills. All rights reserved.
//
import UIKit
import AWSCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AWSDDLog.sharedInstance.logLevel = .verbose // TODO: Disable or reduce log level in production
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance) // TTY = Log everything to Xcode console
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

