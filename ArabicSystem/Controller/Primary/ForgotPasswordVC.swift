//
//  ForgotPasswordVC.swift
//  فخدمتكو
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit
import LanguageManager_iOS

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var txt_Email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Forget password".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Send(_ sender: UIButton) {
        if self.txt_Email.hasText {
            reset_Password()
        } else {
            self.alert(alertmessage: "Please enter the valid email address".localiz())
        }
    }
}

extension ForgotPasswordVC {
    
    func reset_Password()
    {
        Api.shared.forget_Password(self, param_ResetPassword()) { responseData in
            if responseData.status == "1" {
                Utility.showAlertWithAction(withTitle: k.appName, message: "New password has sent to your email".localiz(), delegate: nil, parentViewController: self) { bool in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: responseData.message ?? "", delegate: nil, parentViewController: self)
            }
        }
    }
    
    func param_ResetPassword() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["email"]                  = txt_Email.text as AnyObject
        return dict
    }
}
