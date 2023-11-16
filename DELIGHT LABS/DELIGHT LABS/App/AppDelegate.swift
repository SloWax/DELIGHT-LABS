//
//  AppDelegate.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainTC = MainTC()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = mainTC
        window?.makeKeyAndVisible()
        
        return true
    }
}

