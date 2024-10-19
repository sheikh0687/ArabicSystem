//
//  ContactUsVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 14/02/24.
//

import UIKit
import LanguageManager_iOS

class ContactUsVC: UIViewController {

    @IBOutlet weak var txt_Message: UITextView!
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_Message.addHint("Enter".localiz())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Contact Us".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Send(_ sender: UIButton) {
        if txt_Name.hasText && txt_Message.hasText && txt_Email.hasText {
            contact()
        } else {
            self.alert(alertmessage: "Please enter the required details!".localiz())
        }
    }
    
    func contact()
    {
        Api.shared.contactUs(self, self.paramDetails()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "We will contact you soon".localiz(), delegate: nil, parentViewController: self) { boool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["name"]                   = self.txt_Name.text as AnyObject
        dict["contact_number"]         = k.emptyString as AnyObject
        dict["email"]                  = self.txt_Email.text as AnyObject
        dict["feedback"]               = self.txt_Message.text as AnyObject
        print(dict)
        return dict
    }
}
