//
//  Switcher.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 16/02/24.
//

import Foundation

class Switcher {
    
    class func check_LoginStatus()
    {
        let statuss = k.userDefault.bool(forKey: k.session.status)
        
        if statuss {
            let homeVC = kStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            let checkVC = UINavigationController(rootViewController: homeVC)
            
            kAppDelegate.window?.rootViewController = checkVC
            kAppDelegate.window?.makeKeyAndVisible()
        } else {
            if logout {
                let rootVC = kStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                let checkVC = UINavigationController(rootViewController: rootVC)
                
                kAppDelegate.window?.rootViewController = checkVC
                kAppDelegate.window?.makeKeyAndVisible()
            } else {
                let rootVC = kStoryboard.instantiateViewController(withIdentifier: "TypeVC") as! TypeVC
                let checkVC = UINavigationController(rootViewController: rootVC)
                
                kAppDelegate.window?.rootViewController = checkVC
                kAppDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
