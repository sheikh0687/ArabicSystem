//
//  LoginVC.swift
//  فخدمتكو
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit
import LanguageManager_iOS

class LoginVC: UIViewController {

    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var btn_RememberOt: UIButton!
    @IBOutlet weak var btn_DontHaveAccount: UILabel!
    
    @IBOutlet weak var lbl_LoginToYourAccount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      changeStaticLangauge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configure_RememberMe()
         self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Sign In Now".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_LoginToYourAccount.text = "Login to your account"
            self.btn_RememberOt.setTitle("Remember Me", for: .normal)
            self.btn_DontHaveAccount.text = "Don't have an account?"
            self.txt_Password.placeholder = "Password"
        } else {
            self.lbl_LoginToYourAccount.text = "تسجيل الدخول إلى حسابك"
            self.btn_RememberOt.setTitle("تذكرني", for: .normal)
            self.btn_DontHaveAccount.text = "ليس لديك حساب؟"
            self.txt_Password.placeholder = "كلمة المرور"
        }
    }
    
    @IBAction func btn_Register(_ sender: UIButton) {
        let vc = kStoryboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configure_RememberMe()
    {
        let rememberMe = UserDefaults.standard.bool(forKey: k.session.rememberMe)
        if rememberMe {
            self.btn_RememberOt.setImage(R.image.rectangleChecked(), for: .normal)
            let userEmail = k.userDefault.value(forKey: k.session.userEmail) as! String
            let userPassword = k.userDefault.value(forKey: k.session.userPassword) as! String
            self.txt_Email.text = userEmail
            self.txt_Password.text = userPassword
        } else {
            self.btn_RememberOt.setImage(R.image.rectangleUncheck(), for: .normal)
            self.txt_Email.text = ""
            self.txt_Password.text = ""
        }
    }
    
    @IBAction func btn_RememberMe(_ sender: UIButton) {
        if btn_RememberOt.image(for: .normal) == R.image.rectangleUncheck() {
            self.btn_RememberOt.setImage(R.image.rectangleChecked(), for: .normal)
            UserDefaults.standard.set(true, forKey: k.session.rememberMe)
            let userEmail = self.txt_Email.text
            let userPassword = self.txt_Password.text
            UserDefaults.standard.setValue(userEmail, forKey: k.session.userEmail)
            UserDefaults.standard.setValue(userPassword, forKey: k.session.userPassword)
        } else {
            self.btn_RememberOt.setImage(R.image.rectangleUncheck(), for: .normal)
            UserDefaults.standard.set(false, forKey: k.session.rememberMe)
            UserDefaults.standard.removeObject(forKey: k.session.userEmail)
            UserDefaults.standard.removeObject(forKey: k.session.userPassword)
        }
    }
    
    @IBAction func btn_ForgotPassword(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_Login(_ sender: UIButton) {
        if txt_Email.hasText && txt_Password.hasText {
            self.call_Login()
        } else {
            self.alert(alertmessage: "Please enter the required details!".localiz())
        }
    }
}

extension LoginVC {
    
    
    func call_Login()
    {
        Api.shared.login(self, param_Login()) { responseData in
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
            k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
            k.userDefault.set(responseData.mobile ?? "", forKey: k.session.mobileNum)
            k.userDefault.set("\(responseData.first_name ?? "") \(responseData.last_name ?? "")", forKey: k.session.userName)
            Switcher.check_LoginStatus()
        }
    }
    
    func param_Login() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["email"]                  = self.txt_Email.text as AnyObject
        dict["password"]               = self.txt_Password.text as AnyObject
        dict["lat"]                    = kAppDelegate.CURRENT_LAT as AnyObject
        dict["lon"]                    = kAppDelegate.CURRENT_LON as AnyObject
        dict["register_id"]            = k.emptyString as AnyObject
        dict["ios_register_id"]        = k.iosRegisterId as AnyObject
        print(dict)
        return dict
    }
}
