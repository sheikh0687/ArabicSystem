//
//  ChangePasswordVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 14/02/24.
//

import UIKit
import LanguageManager_iOS

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var txt_CurrentPassword: UITextField!
    @IBOutlet weak var txt_NewPassword: UITextField!
    @IBOutlet weak var txt_ConfirmPassword: UITextField!
    
    @IBOutlet weak var btn_SaveOt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStaticLangauge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Change Password".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.txt_NewPassword.placeholder = "New Password"
            self.btn_SaveOt.setTitle("Save", for: .normal)
        } else {
            self.txt_NewPassword.placeholder = "كلمة المرور الجديدة"
            self.btn_SaveOt.setTitle("حفظ", for: .normal)
        }
    }
    
    @IBAction func btn_Save(_ sender: UIButton) {
        if txt_CurrentPassword.hasText && txt_NewPassword.hasText && txt_ConfirmPassword.hasText {
            change_Password()
        } else {
            self.alert(alertmessage: "Please enter the required details!".localiz())
        }
    }
}

extension ChangePasswordVC {
    
    func change_Password()
    {
        Api.shared.change_Password(self, param_Details()) { responseData in
            if responseData.status == "1" {
                Utility.showAlertWithAction(withTitle: k.appName, message: "Password changed successfully".localiz(), delegate: nil, parentViewController: self) { bool in
                    Switcher.check_LoginStatus()
                }
            } else {
                self.alert(alertmessage: responseData.message ?? "")
            }
        }
    }
    
    func param_Details() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["old_password"]           = self.txt_CurrentPassword.text as AnyObject
        dict["password"]               = txt_NewPassword.text as AnyObject
        return dict
    }
}
