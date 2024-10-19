//
//  TypeVC.swift
//  فخدمتكو
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit
import DropDown
import LanguageManager_iOS

class TypeVC: UIViewController {
    
    @IBOutlet weak var lbl_Language: UILabel!
    
    var dropDown = DropDown()
    
    let language = k.userDefault.value(forKey: k.session.language) as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_Language.text = "English"
        } else {
            self.lbl_Language.text = "العربية"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_SignIn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_Register(_ sender: UIButton) {
        let vc = kStoryboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_Language(_ sender: UIButton) {
        dropDown.anchorView = sender
        dropDown.show()
        switch language {
        case "english":
            dropDown.dataSource = ["English","Arabic"]
            dropDown.bottomOffset = CGPoint(x: -60, y: 40)
        default:
            dropDown.dataSource = ["الإنجليزية","العربية"]
            dropDown.bottomOffset = CGPoint(x: 280, y: 40)
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lbl_Language.text = item
            print(self.lbl_Language.text ?? "")
            if index == 0 {
                k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
                LanguageManager.shared.setLanguage(language: .en)
                Switcher.check_LoginStatus()
            } else  {
                k.userDefault.set(emLang.arabic.rawValue, forKey: k.session.language)
                LanguageManager.shared.setLanguage(language: .ar)
                Switcher.check_LoginStatus()
            }
        }
    }
}
