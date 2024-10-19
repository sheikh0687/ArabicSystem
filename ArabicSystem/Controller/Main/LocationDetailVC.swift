//
//  LocationDetailVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 14/02/24.
//

import UIKit
import LanguageManager_iOS

class LocationDetailVC: UIViewController {

    @IBOutlet weak var txt_Address: UITextView!
    @IBOutlet weak var btn_AddressOt: UIButton!
    @IBOutlet weak var txt_BeachName: UITextField!
    @IBOutlet weak var btn_VillaOt: UIButton!
    @IBOutlet weak var btn_AppartmentOt: UIButton!
    @IBOutlet weak var txt_AppartmentNum: UITextField!
    @IBOutlet weak var lbl_SelectAddressText: UILabel!
    
    var cat_Id = ""
    var cat_Name = ""
    var cat_NameAr = ""
    
    var str_StartDate = ""
    var str_StartTime = ""
    var str_EndTime = ""
    
    var numberOf_Maid = ""
    var numberOf_Rooms = ""
    var numberOf_LivingRooms = ""
    var numberOf_Floors = ""
    var numberOf_Hours = ""
    
    var address = ""
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    var house_Type = "Villa"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_VillaOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
        self.txt_Address.text = "Select".localiz()
        self.changeStaticLangauge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Address Detail".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        if LanguageManager.shared.currentLanguage == .en {
            btn_VillaOt.setTitle("Villa", for: .normal)
            btn_AppartmentOt.setTitle("Appartment", for: .normal)
        } else {
            btn_VillaOt.setTitle("فيلا", for: .normal)
            btn_AppartmentOt.setTitle("شقة", for: .normal)
        }

        btn_VillaOt.layoutIfNeeded()
        btn_AppartmentOt.layoutIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_SelectAddressText.text = "Select Address"
        } else {
            self.lbl_SelectAddressText.text = "حدد عنوان"
        }
    }
    
    @IBAction func btn_AddressPicker(_ sender: UIButton) {
        let vc = kStoryboard.instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = { cordinateVal, latVal, lonVal, addressVal in
            self.txt_Address.text = addressVal
            self.address = addressVal
            self.lat = latVal
            self.lon = lonVal
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btn_Viila(_ sender: UIButton) {
        self.btn_VillaOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
        self.btn_AppartmentOt.setImage(R.image.ic_Circle_Black(), for: .normal)
        self.house_Type = "Villa"
    }
    
    @IBAction func btn_Appartmen(_ sender: UIButton) {
        self.btn_AppartmentOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
        self.btn_VillaOt.setImage(R.image.ic_Circle_Black(), for: .normal)
        self.house_Type = "Appartment"
    }
    
    @IBAction func btn_Next(_ sender: UIButton) {
        if !self.address.isEmpty && txt_BeachName.hasText && txt_AppartmentNum.hasText {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AmountVC") as! AmountVC
            vc.cat_Id = cat_Id
            vc.cat_Name = cat_Name
            vc.cat_NameAr = cat_NameAr
            vc.total_Rooms = numberOf_Rooms
            vc.total_LivingRooms = numberOf_LivingRooms
            vc.total_Maids = numberOf_Maid
            vc.start_Date = str_StartDate
            vc.start_Time = str_StartTime
            vc.address = address
            vc.lat = String(lat)
            vc.lon = String(lon)
            vc.beach_Name = txt_BeachName.text ?? ""
            vc.house_Number = txt_AppartmentNum.text ?? ""
            vc.total_Floor = numberOf_Floors
            vc.total_Hours = numberOf_Hours
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.alert(alertmessage: "Please enter the required details!".localiz())
        }
    }
}
