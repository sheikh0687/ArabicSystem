//
//  BookingDetailVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 27/09/24.
//

import UIKit
import LanguageManager_iOS

class BookingDetailVC: UIViewController {
    
    @IBOutlet weak var lbl_ServiceFor: UILabel!
    
    @IBOutlet weak var lbl_TotalMaids: UILabel!
    @IBOutlet weak var lbl_TotalRooms: UILabel!
    @IBOutlet weak var lbl_HowManyLivingRoom: UILabel!
    @IBOutlet weak var lbl_Floor: UILabel!
    @IBOutlet weak var lbl_Hours: UILabel!
    
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_StartTime: UILabel!
    @IBOutlet weak var lbl_EndTime: UILabel!
    
    @IBOutlet weak var lbl_HouseType: UILabel!
    @IBOutlet weak var lbl_BeachName: UILabel!
    @IBOutlet weak var lbl_VillaAppartmentNum: UILabel!
    @IBOutlet weak var lbl_EndTimeHeading: UILabel!
    
    @IBOutlet weak var lbl_Address: UILabel!
    
    @IBOutlet weak var lbl_BaseFee: UILabel!
    @IBOutlet weak var lbl_BookingFee: UILabel!
    @IBOutlet weak var lbl_Tax: UILabel!
    @IBOutlet weak var lbl_TotalFinalAmnt: UILabel!
    
    @IBOutlet weak var lbl_BookinkForText: UILabel!
    @IBOutlet weak var lbl_AprtmentText: UILabel!
    @IBOutlet weak var lbl_HowManyRoomText: UILabel!
    @IBOutlet weak var lbl_HowManyLivingRoomText: UILabel!
    @IBOutlet weak var lbl_DateText: UILabel!
    @IBOutlet weak var lbl_VillaText: UILabel!
    @IBOutlet weak var lbl_AddressText: UILabel!
    @IBOutlet weak var lbl_BookinkFeeText: UILabel!
    @IBOutlet weak var lbl_TaxText: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_CurrentStatusText: UILabel!
    @IBOutlet weak var lbl_FloorText: UILabel!
    @IBOutlet weak var lbl_HowManyHourText: UILabel!
    
    @IBOutlet weak var ROOMVW: UIStackView!
    @IBOutlet weak var LIVINGROOMVW: UIStackView!
    @IBOutlet weak var FLOORVW: UIStackView!
    @IBOutlet weak var HOURVW: UIStackView!
    
    var requestId = ""
    let isEnglish = LanguageManager.shared.currentLanguage == .en
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeStaticLangauge()
        self.requestDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_BookinkForText.text = "Booking For"
            //            self.lbl_AprtmentText.text = "Apartment Service"
            self.lbl_HowManyRoomText.text = "How many Rooms"
            self.lbl_HowManyLivingRoomText.text = "How many living Rooms"
            self.lbl_DateText.text = "Date"
            self.lbl_VillaText.text = "Villa or Appartment"
            self.lbl_AddressText.text = "Address"
            self.lbl_BookinkFeeText.text = "Booking Fee"
            self.lbl_TaxText.text = "Tax"
            self.lbl_CurrentStatusText.text = "Current Status"
            self.lbl_FloorText.text = "Floor"
            self.lbl_HowManyHourText.text = "How Many Hours"
        } else {
            self.lbl_BookinkForText.text = "الحجز لـ"
            //            self.lbl_AprtmentText.text = "خدمة الشقة"
            self.lbl_HowManyRoomText.text = "كم عدد الغرف"
            self.lbl_HowManyLivingRoomText.text = "كم عدد غرف المعيشة"
            self.lbl_DateText.text = "التاريخ"
            self.lbl_VillaText.text = "فيلا أو شقة"
            self.lbl_AddressText.text = "العنوان"
            self.lbl_BookinkFeeText.text = "رسوم الحجز"
            self.lbl_TaxText.text = "الضريبة"
            self.lbl_CurrentStatusText.text = "الحالة الحالية"
            self.lbl_FloorText.text = "الطابق"
            self.lbl_HowManyHourText.text = "كم عدد الساعات"
        }
    }
}

extension BookingDetailVC {
    
    func requestDetails()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["request_id"] = requestId as AnyObject
        
        print(paramDict)
        
        Api.shared.booking_RequestDetails(self, paramDict) { responseData in
            let obj = responseData
            
            if obj.category_name == "Apartment service" {
                
                self.FLOORVW.isHidden = true
                self.HOURVW.isHidden = true
                self.ROOMVW.isHidden = false
                self.LIVINGROOMVW.isHidden = false
                
                self.lbl_AprtmentText.text = self.isEnglish ? obj.category_name ?? "" : obj.category_name_ar ?? ""
                self.lbl_TotalMaids.text = obj.total_maids ?? ""
                self.lbl_TotalRooms.text = obj.total_rooms ?? ""
                self.lbl_HowManyLivingRoom.text = obj.total_living_rooms ?? ""
                self.lbl_Date.text = obj.start_date ?? ""
                self.lbl_StartTime.text = obj.start_time ?? ""
                self.lbl_BeachName.text = obj.branch ?? ""
                self.lbl_VillaAppartmentNum.text = obj.house_number ?? ""
                self.lbl_Address.text = obj.address ?? ""
                self.lbl_BookingFee.text = "\(k.currency) \(obj.booking_amount ?? "")"
                self.lbl_TaxText.text = self.isEnglish ? "Tax (\(obj.tax_percentage ?? "")%)" : "الضريبة (\(obj.tax_percentage ?? "")%)"
                self.lbl_Tax.text = "\(k.currency) \(obj.tax_amount ?? "")"
                self.lbl_TotalFinalAmnt.text = "\(k.currency) \(obj.total_amount ?? "")"
                self.lbl_Status.text = obj.status ?? ""
                
            } else if obj.category_name == "Vila service" {
                
                self.HOURVW.isHidden = true
                self.FLOORVW.isHidden = false
                self.ROOMVW.isHidden = true
                self.LIVINGROOMVW.isHidden = true
                
                self.lbl_AprtmentText.text = self.isEnglish ? obj.category_name ?? "" : obj.category_name_ar ?? ""
                self.lbl_TotalMaids.text = obj.total_maids ?? ""
//                self.lbl_TotalRooms.text = obj.total_rooms ?? ""
//                self.lbl_HowManyLivingRoom.text = obj.total_living_rooms ?? ""
                self.lbl_Date.text = obj.start_date ?? ""
                self.lbl_StartTime.text = obj.start_time ?? ""
                self.lbl_BeachName.text = obj.branch ?? ""
                self.lbl_VillaAppartmentNum.text = obj.house_number ?? ""
                self.lbl_Address.text = obj.address ?? ""
                self.lbl_BookingFee.text = "\(k.currency) \(obj.booking_amount ?? "")"
                self.lbl_TaxText.text = self.isEnglish ? "Tax (\(obj.tax_percentage ?? "")%)" : "الضريبة (\(obj.tax_percentage ?? "")%)"
                self.lbl_Tax.text = "\(k.currency) \(obj.tax_amount ?? "")"
                self.lbl_TotalFinalAmnt.text = "\(k.currency) \(obj.total_amount ?? "")"
                self.lbl_Status.text = obj.status ?? ""
                self.lbl_Floor.text = obj.total_floors ?? ""
            } else {
                
                self.FLOORVW.isHidden = true
                self.ROOMVW.isHidden = true
                self.LIVINGROOMVW.isHidden = true
                self.HOURVW.isHidden = false
                
                self.lbl_AprtmentText.text = self.isEnglish ? obj.category_name ?? "" : obj.category_name_ar ?? ""
                self.lbl_TotalMaids.text = obj.total_maids ?? ""
                self.lbl_Hours.text = obj.total_visit_hours ?? ""
                self.lbl_Date.text = obj.start_date ?? ""
                self.lbl_StartTime.text = obj.start_time ?? ""
                self.lbl_BeachName.text = obj.branch ?? ""
                self.lbl_VillaAppartmentNum.text = obj.house_number ?? ""
                self.lbl_Address.text = obj.address ?? ""
                self.lbl_BookingFee.text = "\(k.currency) \(obj.booking_amount ?? "")"
                self.lbl_TaxText.text = self.isEnglish ? "Tax (\(obj.tax_percentage ?? "")%)" : "الضريبة (\(obj.tax_percentage ?? "")%)"
                self.lbl_Tax.text = "\(k.currency) \(obj.tax_amount ?? "")"
                self.lbl_TotalFinalAmnt.text = "\(k.currency) \(obj.total_amount ?? "")"
                self.lbl_Status.text = obj.status ?? ""
            }
        }
    }
}
