//
//  OtpVC.swift
//  City Spriiint
//
//  Created by Techimmense Software Solutions on 21/07/23.
//

import UIKit
import LanguageManager_iOS

class OtpVC: UIViewController {

    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    
    var params: [String: String] = [:]
    var mobileNo = ""
    var mobile = ""
    var verificationCode = ""
    var verifyCode = ""
    
    var cloResend:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblMobile.text = "A code has been sent to \(self.mobileNo)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Verification Code".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func txt1(_ sender: UITextField) {
        if sender.text! != "" {
            self.txt2.becomeFirstResponder()
        }
    }
    
    @IBAction func txt2(_ sender: UITextField) {
        if sender.text! == "" {
            self.txt1.becomeFirstResponder()
        } else {
            self.txt3.becomeFirstResponder()
        }
    }
    
    @IBAction func txt3(_ sender: UITextField) {
        if sender.text! == "" {
            self.txt2.becomeFirstResponder()
        } else {
            self.txt4.becomeFirstResponder()
        }
    }
    
    @IBAction func txt4(_ sender: UITextField) {
        if sender.text! == "" {
            self.txt3.becomeFirstResponder()
        }
    }
    
    @IBAction func btn_Resend(_ sender: UIButton) {
        self.cloResend?()
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if txt1.hasText && txt2.hasText && txt3.hasText && txt4.hasText {
            let v1 = self.txt1.text!
            let v2 = self.txt2.text!
            let v3 = self.txt3.text!
            let v4 = self.txt4.text!

            let verificationCode = "\(v1)\(v2)\(v3)\(v4)"
            self.otpVerification(verificationCode)
        } else {
            self.alert(alertmessage: "Please Enter Otp")
        }
    }
    
    func otpVerification(_ verificationCode: String) {
        let otpp = String(verificationCode) 
        if self.verificationCode == otpp {
            signUp()
        } else {
            self.txt1.text = ""
            self.txt2.text = ""
            self.txt3.text = ""
            self.txt4.text = ""
            self.txt1.becomeFirstResponder()
            self.alert(alertmessage: "Invalid Otp")
        }
    }
    
    func signUp()
    {
        print(dictSignup)
        Api.shared.signup(self, dictSignup) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Account created successfully".localiz(), delegate: nil, parentViewController: self) { (boool) in
                k.userDefault.set(true, forKey: k.session.status)
                k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
                k.userDefault.set("\(responseData.first_name ?? "") \(responseData.last_name ?? "")", forKey: k.session.userName)
                k.userDefault.set(responseData.image ?? "", forKey: k.session.userImage)
                k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
                k.userDefault.set(responseData.mobile ?? "", forKey: k.session.mobileNum)
                Switcher.check_LoginStatus()
            }
        }
    }
}
