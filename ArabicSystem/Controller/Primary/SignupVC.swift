//
//  SignUpVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 17/02/24.
//

import UIKit
import CountryPickerView
import LanguageManager_iOS

class SignUpVC: UIViewController {
    
    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_Mobile: UITextField!
    @IBOutlet weak var txt_SecondMobile: UITextField!
    @IBOutlet weak var txt_MobileCode: UITextField!
    @IBOutlet weak var txt_SecondMobileCode: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var txt_ConfrimPassword: UITextField!
    @IBOutlet weak var btn_ReadTermCondition: UIButton!
    @IBOutlet weak var lbl_TermAndCondition: UILabel!
    @IBOutlet weak var btn_RegisterOt: UIButton!
    
    @IBOutlet weak var lbl_AlreadyHaveAcoount: UILabel!
    
    weak var cpvTextField1: CountryPickerView!
    weak var cpvTextField2: CountryPickerView!
    var phoneKey:String?
    var phoneNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_TermAndCondition.setColor(for: "Terms & Conditions", with: hexStringToUIColor(hex: "#08A48C"))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
        lbl_TermAndCondition.isUserInteractionEnabled = true
        lbl_TermAndCondition.addGestureRecognizer(tapGesture)
        configureCountryPicker1()
        configureCountryPicker2()
        self.btn_ReadTermCondition.setImage(R.image.rectangleUncheck(), for: .normal)
        changeStaticLangauge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Sign Up".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func labelClicked()
    {
        let vc = kStoryboard.instantiateViewController(withIdentifier: "UserInfoVC") as! UserInfoVC
        vc.which_Is = "TermAndCondition"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_TermAndCondition.text = "I have read the Terms & Conditions and accept them"
            self.btn_RegisterOt.setTitle("REGISTER", for: .normal)
            self.lbl_AlreadyHaveAcoount.text = "Already have an account?"
            self.txt_SecondMobile.placeholder = "Second Phone Number"
            self.txt_Password.placeholder = "Password"
        } else {
            self.lbl_TermAndCondition.text = "لقد قرأت الشروط والأحكام وقبلتها"
            self.btn_RegisterOt.setTitle("تسجيل", for: .normal)
            self.lbl_AlreadyHaveAcoount.text = "هل لديك حساب؟"
            self.txt_SecondMobile.placeholder = "رقم الهاتف الثاني"
            self.txt_Password.placeholder = "كلمة المرور"
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
        self.cpvTextField1 = cp
        let countryCode = "SA"
        self.cpvTextField1.setCountryByCode(countryCode)
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
        self.cpvTextField2 = cp
        let countryCode = "SA"
        self.cpvTextField2.setCountryByCode(countryCode)
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        self.phoneKey = cp.selectedCountry.phoneCode
        cp.countryDetailsLabel.font = UIFont.systemFont(ofSize: 12)
        cp.font = UIFont.systemFont(ofSize: 12)
    }
    
    @IBAction func btn_ReadTerms(_ sender: UIButton) {
        if btn_ReadTermCondition.image(for: .normal) == UIImage(named: "RectangleUncheck") {
            btn_ReadTermCondition.setImage(UIImage(named: "RectangleChecked"), for: .normal)
        } else {
            btn_ReadTermCondition.setImage(UIImage(named: "RectangleUncheck"), for: .normal)
        }
    }
    
    @IBAction func btn_Login(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Register(_ sender: UIButton) {
        if txt_FirstName.text!.isEmpty {
            self.alert(alertmessage: "Required first name".localiz())
        } else if txt_LastName.text!.isEmpty {
            self.alert(alertmessage: "Required last name".localiz())
        } else if txt_Email.text!.isEmpty {
            self.alert(alertmessage: "Please enter email".localiz())
        } else if txt_Mobile.text!.isEmpty {
            self.alert(alertmessage: "Please enter mobile number".localiz())
        } else if txt_SecondMobile.text!.isEmpty {
            self.alert(alertmessage: "Please enter any other number".localiz())
        } else if txt_Password.text!.isEmpty {
            self.alert(alertmessage: "Please enter the password".localiz())
        } else if txt_ConfrimPassword.text!.isEmpty {
            self.alert(alertmessage: "Please confirm the password".localiz())
        } else if btn_ReadTermCondition.image(for: .normal) == UIImage(named: "rectangleUncheck") {
            self.alert(alertmessage: "Please read the terms and condition".localiz())
        } else {
            self.register()
        }
    }
}

extension SignUpVC {
    
//    func verifyNumber(shouldNavigate: Bool = true) {
//        Api.shared.verifyOtp(self, self.paramVerifyNum()) { responseData in
//            print(responseData.code ?? 0)
//            self.collectData()
//            print(self.collectData())
//
//            // Check if navigation should occur
//            if shouldNavigate {
//                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
//                vc.verificationCode = String(responseData.code ?? 0)
//                vc.cloResend = { () in
//                    // Call verifyNumber with shouldNavigate set to false
//                    self.verifyNumber(shouldNavigate: false)
//                }
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//    }
//    
//    func paramVerifyNum() -> [String : AnyObject] {
//        var dict: [String : AnyObject] = [:]
//        dict["mobile_with_code"]       = "\(self.phoneKey ?? "")\(self.txt_Mobile.text!)" as AnyObject
//        dict["mobile"]                 = self.txt_Mobile.text as AnyObject
//        dict["email"]                  = self.txt_Email.text as AnyObject
//        dict["type"]                   = k.emptyString as AnyObject
//        print(dict)
//        return dict
//    }
//    
//    
//    func collectData()
//    {
//        dictSignup["first_name"]             = txt_FirstName.text as AnyObject
//        dictSignup["last_name"]              = txt_LastName.text as AnyObject
//        dictSignup["email"]                  = txt_Email.text as AnyObject
//        dictSignup["password"]               = txt_Password.text as AnyObject
//        dictSignup["mobile"]                 = txt_Mobile.text as AnyObject
//        dictSignup["mobile_with_code"]       = txt_MobileCode.text as AnyObject
//        dictSignup["mobile1"]                = txt_SecondMobile.text as AnyObject
//        dictSignup["mobile_with_code1"]      = txt_SecondMobileCode.text as AnyObject
//        dictSignup["lat"]                    = kAppDelegate.CURRENT_LAT as AnyObject
//        dictSignup["lon"]                    = kAppDelegate.CURRENT_LON as AnyObject
//        dictSignup["register_id"]            = k.emptyString as AnyObject
//        dictSignup["ios_register_id"]        = k.iosRegisterId as AnyObject
//    }
    
    func register()
    {
        Api.shared.signup(self, param_Signup()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Account created successfully".localiz(), delegate: nil, parentViewController: self) { bool in
                k.userDefault.set(true, forKey: k.session.status)
                k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
                k.userDefault.set(responseData.mobile ?? "", forKey: k.session.mobileNum)
                k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
                k.userDefault.set("\(responseData.first_name ?? "") \(responseData.last_name ?? "")", forKey: k.session.userName)
                Switcher.check_LoginStatus()
            }
        }
    }
    
    
    
    func param_Signup() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["first_name"]             = txt_FirstName.text as AnyObject
        dict["last_name"]              = txt_LastName.text as AnyObject
        dict["email"]                  = txt_Email.text as AnyObject
        dict["password"]               = txt_Password.text as AnyObject
        dict["mobile"]                 = txt_Mobile.text as AnyObject
        dict["mobile_with_code"]       = txt_MobileCode.text as AnyObject
        dict["mobile1"]                = txt_SecondMobile.text as AnyObject
        dict["mobile_with_code1"]      = txt_SecondMobileCode.text as AnyObject
        dict["lat"]                    = kAppDelegate.CURRENT_LAT as AnyObject
        dict["lon"]                    = kAppDelegate.CURRENT_LON as AnyObject
        dict["register_id"]            = k.emptyString as AnyObject
        dict["ios_register_id"]        = k.iosRegisterId as AnyObject
        return dict
    }
}


extension SignUpVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
        //        self.countryCode = country.phoneCode
        //        self.countryCodeWithoutPlus = countryCode.replacingOccurrences(of: "+", with: "")
    }
}

extension SignUpVC: CountryPickerViewDataSource {
    
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
