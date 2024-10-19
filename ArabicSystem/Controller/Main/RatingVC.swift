//
//  RatingVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit
import Cosmos
import LanguageManager_iOS

class RatingVC: UIViewController {

    @IBOutlet weak var txt_Review: UITextView!
    @IBOutlet weak var cosmos_View: CosmosView!
    @IBOutlet weak var lbl_SelectRatingText: UILabel!
    
    var request_Id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_Review.addHint("Write Review".localiz())
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_SelectRatingText.text = "Select Rating"
        } else {
            self.lbl_SelectRatingText.text = "اختر التقييم"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Give Rating".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if self.cosmos_View.rating.isZero && self.txt_Review.text.isEmpty {
            self.alert(alertmessage: "Please give the rating!".localiz())
        } else {
            review()
        }
    }
}

extension RatingVC {
    
    func review()
    {
        Api.shared.add_UserRating(self, param_AddReview()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Review added successfully".localiz(), delegate: nil, parentViewController: self) { bool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func param_AddReview() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["form_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["request_id"]             = request_Id as AnyObject
        dict["rating"]                 = cosmos_View.rating as AnyObject
        dict["feedback"]               = txt_Review.text as AnyObject
        return dict
    }
}
