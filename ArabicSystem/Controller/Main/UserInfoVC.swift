//
//  UserInfoVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 19/03/24.
//

import UIKit
import LanguageManager_iOS

class UserInfoVC: UIViewController {

    @IBOutlet weak var lbl_TermsCondition: UILabel!
    
    var which_Is = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        if which_Is == "TermAndCondition" {
            setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Term and Condition".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        } else {
            setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Privacy Policy".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        }
        terms_Condition()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension UserInfoVC {
    
    func terms_Condition()
    {
        Api.shared.user_Page_Detail(self) { responseData in
            let obj = responseData
            if self.which_Is == "TermAndCondition" {
                if LanguageManager.shared.currentLanguage == .en {
                    let html = obj.term ?? ""
                    if let attributedString = html.htmlAttributedString3 {
                        self.lbl_TermsCondition.attributedText = attributedString
                    }
                } else {
                    let html = obj.term_sp ?? ""
                    if let attributedString = html.htmlAttributedString3 {
                        self.lbl_TermsCondition.attributedText = attributedString
                    }
                }
            } else {
                if LanguageManager.shared.currentLanguage == .en {
                    let html = obj.privacy ?? ""
                    if let attributedString = html.htmlAttributedString3 {
                        self.lbl_TermsCondition.attributedText = attributedString
                    }
                } else {
                    let html = obj.privacy_sp ?? ""
                    if let attributedString = html.htmlAttributedString3 {
                        self.lbl_TermsCondition.attributedText = attributedString
                    }
                }
            }
        }
    }
}
