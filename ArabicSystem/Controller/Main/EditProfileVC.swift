//
//  EditProfileVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 14/02/24.
//

import UIKit
import CountryPickerView
import LanguageManager_iOS

class EditProfileVC: UIViewController {

    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_Mobile: UITextField!
    @IBOutlet weak var txt_SecondMobile: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_MobileCode: UITextField!
    @IBOutlet weak var txt_SecondMobileCode: UITextField!
    @IBOutlet weak var btn_ProfileImg: UIButton!
    
    var image = UIImage()
    
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    var phoneNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCountryPicker1()
        self.configureCountryPicker2()
        self.changeStaticLangauge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.profile_Details()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Edit Profile".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.txt_SecondMobile.placeholder = "Second Phone Number"
        } else {
            self.txt_SecondMobile.placeholder = "رقم الهاتف الثاني"
        }
    }
    
    func configureCountryPicker1()
    {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 80, height: 14))
        cp.flagImageView.isHidden = true
        if LanguageManager.shared.currentLanguage == .en {
            txt_MobileCode.leftView = cp
            txt_MobileCode.leftViewMode = .always
        } else {
            txt_MobileCode.rightView = cp
            txt_MobileCode.rightViewMode = .always
        }
        self.cpvTextField = cp
        let countryCode = "SA"
        self.cpvTextField.setCountryByCode(countryCode)
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        self.phoneKey = cp.selectedCountry.phoneCode
        cp.countryDetailsLabel.font = UIFont.systemFont(ofSize: 12)
        cp.font = UIFont.systemFont(ofSize: 12)
    }
    
    
    func configureCountryPicker2()
    {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 80, height: 14))
        cp.flagImageView.isHidden = true
        if LanguageManager.shared.currentLanguage == .en {
            txt_SecondMobileCode.leftView = cp
            txt_SecondMobileCode.leftViewMode = .always
        } else {
            txt_SecondMobileCode.rightView = cp
            txt_SecondMobileCode.rightViewMode = .always
        }
        
        self.cpvTextField = cp
        let countryCode = "SA"
        self.cpvTextField.setCountryByCode(countryCode)
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        self.phoneKey = cp.selectedCountry.phoneCode
        cp.countryDetailsLabel.font = UIFont.systemFont(ofSize: 12)
        cp.font = UIFont.systemFont(ofSize: 12)
    }
    
    @IBAction func btn_Image(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { image in
            self.image = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btn_Update(_ sender: UIButton) {
        if txt_FirstName.hasText && txt_LastName.hasText && txt_Mobile.hasText && txt_SecondMobile.hasText && txt_Email.hasText {
            update_Profile()
        } else {
            self.alert(alertmessage: "Please enter the required details".localiz())
        }
    }
}

extension EditProfileVC {
    
    func profile_Details()
    {
        Api.shared.user_Profile(self) { responseData in
            let obj = responseData
            self.txt_FirstName.text = obj.first_name ?? ""
            self.txt_LastName.text = obj.last_name ?? ""
            self.txt_Mobile.text = obj.mobile ?? ""
            self.txt_SecondMobile.text = obj.mobile1 ?? ""
            self.txt_Email.text = obj.email ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.downloadImageBySDWebImage(obj.image ?? "") { image, error in
                    if image != nil {
                        self.btn_ProfileImg.setImage(image, for: .normal)
                    } else {
                        self.btn_ProfileImg.setImage(UIImage(named: "profile_ic"), for: .normal)
                    }
                }
            } else {
                self.btn_ProfileImg.setImage(UIImage(named: "profile_ic"), for: .normal)
            }
        }
    }
}

extension EditProfileVC {
    
    func update_Profile()
    {
        Api.shared.update_UserProfile(self, param_UpdateProfile(), images: param_UpdateImg(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Profile updated successfully!".localiz(), delegate: nil, parentViewController: self) { bool in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func param_UpdateProfile() -> [String : String]
    {
        var dict: [String : String] = [:]
        dict["user_id"]             = k.userDefault.value(forKey: k.session.userId) as? String
        dict["first_name"]          = txt_FirstName.text
        dict["last_name"]           = txt_LastName.text
        dict["mobile"]              = txt_Mobile.text
        dict["mobile_with_code"]    = txt_MobileCode.text
        dict["mobile1"]             = txt_SecondMobile.text
        dict["mobile_with_code1"]   = txt_SecondMobileCode.text
        dict["email"]               = txt_Email.text
        return dict
    }
    
    func param_UpdateImg() -> [String : UIImage]
    {
        var img_Dict: [String : UIImage] = [:]
        img_Dict["image"]                = self.image
        return img_Dict
    }
    
}

extension EditProfileVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
        //        self.countryCode = country.phoneCode
        //        self.countryCodeWithoutPlus = countryCode.replacingOccurrences(of: "+", with: "")
    }
}

extension EditProfileVC: CountryPickerViewDataSource {
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["GB"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Preferred title"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
}
