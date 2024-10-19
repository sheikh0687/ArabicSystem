//
//  TabBarVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit
import LanguageManager_iOS

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        updateTabBarTitles()
    }
    
    private func updateTabBarTitles() {
        // Assuming tab at index 1 is the one you want to update
        if let viewControllers = self.viewControllers {
            let vC0 = viewControllers[0]
            let vC1 = viewControllers[1]
            let vC2 = viewControllers[2]
            let vC3 = viewControllers[3]
            
            // Check the current language and update the title accordingly
            if LanguageManager.shared.currentLanguage == .en {
                vC0.tabBarItem.title = "Home"
                vC1.tabBarItem.title = "Offers"
                vC2.tabBarItem.title = "Notifications"
                vC3.tabBarItem.title = "Settings"
            } else {
                vC0.tabBarItem.title = "الصفحة الرئيسية"
                vC1.tabBarItem.title = "العروض"
                vC2.tabBarItem.title = "الإشعارات"
                vC3.tabBarItem.title = "الإعدادات"
            }
        }
    }
    
    
}
