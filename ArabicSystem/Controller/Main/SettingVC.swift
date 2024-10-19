//
//  SettingVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit
import LanguageManager_iOS

class SettingVC: UIViewController {
    
    @IBOutlet weak var lbl_UpdateProfileText: UILabel!
    @IBOutlet weak var lbl_ChangeLangugeText: UILabel!
    @IBOutlet weak var lbl_InviteFriendText: UILabel!
    @IBOutlet weak var lbl_SupportText: UILabel!
    @IBOutlet weak var lbl_LogoutText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStaticLangauge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_UpdateProfileText.text = "Update Profile"
            self.lbl_ChangeLangugeText.text = "Change Language"
            self.lbl_InviteFriendText.text = "Invite Friends"
            self.lbl_SupportText.text = "Support"
            self.lbl_LogoutText.text = "Logout"
        } else {
            self.lbl_UpdateProfileText.text = "تحديث الملف الشخصي"
            self.lbl_ChangeLangugeText.text = "تغيير اللغة"
            self.lbl_InviteFriendText.text = "دعوة الأصدقاء"
            self.lbl_SupportText.text = "الدعم"
            self.lbl_LogoutText.text = "تسجيل الخروج"
        }
    }
    
    @IBAction func btn_UpdateProfile(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_ChangePassword(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_ChangeLanguage(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier:  "LanguageVC") as! LanguageVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_InviteFriends(_ sender: UIButton) {
        Utility.doShare("www.google.com", "www.google.com", self)
    }
    
    @IBAction func btn_Booking(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_TermsCondition(_ sender: UIButton) {
        let vc = kStoryboard.instantiateViewController(withIdentifier: "UserInfoVC") as! UserInfoVC
        vc.which_Is = "TermAndCondition"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_PrivacyPolicy(_ sender: UIButton) {
        let vc = kStoryboard.instantiateViewController(withIdentifier: "UserInfoVC") as! UserInfoVC
        vc.which_Is = "PrivacyPolicy"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_ContactUs(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_Support(_ sender: UIButton) {
        let adminNum = "966559003760"
        
        if let url = URL(string: "https://wa.me/\(adminNum)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("No Whats can be there!!")
        }
    }
    
    @IBAction func btn_DeleteAccount(_ sender: UIButton) {
        Utility.showAlertYesNoAction(withTitle: k.appName, message: "Are you sure you want to delete your account".localiz(), delegate: nil, parentViewController: self) { boool in
            if boool {
                self.deleteAccount()
            } else {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func btn_Logout(_ sender: UIButton) {
        logout = true
        UserDefaults.standard.removeObject(forKey: k.session.status)
        UserDefaults.standard.synchronize()
        Switcher.check_LoginStatus()
    }
}

extension SettingVC {
    
    func deleteAccount()
    {
        Api.shared.delete_Account(self) { responseData in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            Switcher.check_LoginStatus()
        }
    }
}
