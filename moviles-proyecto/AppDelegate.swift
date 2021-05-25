//
//  AppDelegate.swift
//  moviles-proyecto
//
//  Created by user189615 on 5/25/21.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return ( UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.landscapeRight.rawValue | UIInterfaceOrientationMask.landscapeLeft.rawValue) )
    }
}
