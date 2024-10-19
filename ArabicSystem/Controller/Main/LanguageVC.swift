//
//  LanguageVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 14/02/24.
//

import UIKit
import LanguageManager_iOS

class LanguageVC: UIViewController {
    
    @IBOutlet weak var btn_EnglishOt: UIButton!
    @IBOutlet weak var btn_ArabicOt: UIButton!
    
    @IBOutlet weak var lbl_SelectLanText: UILabel!
    @IBOutlet weak var btn_SaveText: UIButton!
    
    var selected_Language:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStaticLangauge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Language".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        if LanguageManager.shared.currentLanguage == .en {
            self.btn_EnglishOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            self.btn_ArabicOt.setImage(R.image.ic_Circle_Black(), for: .normal)
            
        } else {
            self.btn_EnglishOt.setImage(R.image.ic_Circle_Black(), for: .normal)
            self.btn_ArabicOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_SelectLanText.text = "Select Language"
            self.btn_EnglishOt.setTitle("English", for: .normal)
            self.btn_ArabicOt.setTitle("Arabic", for: .normal)
            self.btn_SaveText.setTitle("Save", for: .normal)
        } else {
            self.lbl_SelectLanText.text = "اختر اللغة"
            self.btn_EnglishOt.setTitle("الإنجليزية", for: .normal)
            self.btn_ArabicOt.setTitle("العربية", for: .normal)
            self.btn_SaveText.setTitle("حفظ", for: .normal)
        }
    }
    
    @IBAction func btn_Languages(_ sender: UIButton) {
        
        if sender.tag == 0 {
            self.btn_EnglishOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            self.btn_ArabicOt.setImage(R.image.ic_Circle_Black(), for: .normal)
            selected_Language = "en"
        } else {
            self.btn_EnglishOt.setImage(R.image.ic_Circle_Black(), for: .normal)
            self.btn_ArabicOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            selected_Language = "ar"
        }
        
    }
    
    @IBAction func btn_Save(_ sender: UIButton) {
        switch selected_Language {
        case "en":
            k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
            LanguageManager.shared.setLanguage(language: .en)
            Switcher.check_LoginStatus()
        default:
            k.userDefault.set(emLang.arabic.rawValue, forKey: k.session.language)
            LanguageManager.shared.setLanguage(language: .ar)
            Switcher.check_LoginStatus()
        }
    }
}
