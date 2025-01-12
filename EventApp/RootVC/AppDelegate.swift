//
//  AppDelegate.swift
//  EventApp 1
//
//  Created by Vova SKR on 22/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let rootViewController = RootViewController()
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
    
}


extension AppDelegate {
    
    static var shared: AppDelegate? {
        
        UIApplication.shared.delegate as? AppDelegate
    }
    
    var rootViewController: RootViewController? {
        
        window?.rootViewController as? RootViewController
    }
}
