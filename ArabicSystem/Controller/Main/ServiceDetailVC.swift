//
//  ServiceDetailVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 14/02/24.
//

import UIKit
import DropDown
import LanguageManager_iOS

class ServiceDetailVC: UIViewController {
    
    @IBOutlet weak var btnDrop1: UIButton!
    @IBOutlet weak var btnDrop2: UIButton!
    @IBOutlet weak var btn_StartDate: UIButton!
    @IBOutlet weak var btn_StartTime: UIButton!
    @IBOutlet weak var btn_EndTime: UIButton!
    
    @IBOutlet weak var lbl_StartDateText: UILabel!
    @IBOutlet weak var lbl_NoteText: UILabel!
    @IBOutlet weak var lbl_selectFloorText: UILabel!
    @IBOutlet weak var lbl_HoursText: UILabel!
    
    @IBOutlet weak var ROOM_VW: UIView!
    @IBOutlet weak var LIVINGROOM_VW: UIView!
    @IBOutlet weak var FLOOR_VW: UIView!
    @IBOutlet weak var MAID_VW: UIView!
    @IBOutlet weak var HOUR_VW: UIView!
    
    var dropDown1 = DropDown()
    var dropDown2 = DropDown()
    var dropDown3 = DropDown()
    var dropDown4 = DropDown()
    var dropDown5 = DropDown()
    
    var category_Id = ""
    var category_Name = ""
    var categoryNameAR = ""
    
    var total_Rooms = "1"
    var total_LivingRooms = "1"
    var total_Floor = "1"
    var total_Maids = "1"
    var total_Hours = "1"
    
    var start_Date = ""
    var start_Time = ""
    var end_Time = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStaticLangauge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Service Detail".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        
        if LanguageManager.shared.isRightToLeft {
            btn_StartDate.titleLabel?.textAlignment = .right
            btn_StartTime.titleLabel?.textAlignment = .right
            btn_EndTime.titleLabel?.textAlignment = .right
        } else {
            btn_StartDate.titleLabel?.textAlignment = .left
            btn_StartTime.titleLabel?.textAlignment = .left
            btn_EndTime.titleLabel?.textAlignment = .left
        }
        
        if category_Name == "Apartment service" {
            FLOOR_VW.isHidden = true
            HOUR_VW.isHidden = true
            ROOM_VW.isHidden = false
            LIVINGROOM_VW.isHidden = false
            MAID_VW.isHidden = false
            total_Floor = "0"
            total_Hours = "0"
        } else if category_Name == "Vila service" {
            HOUR_VW.isHidden = true
            FLOOR_VW.isHidden = false
            ROOM_VW.isHidden = true
            LIVINGROOM_VW.isHidden = true
            MAID_VW.isHidden = false
            total_Hours = "0"
            total_Rooms = "0"
            total_LivingRooms = "0"
        } else {
            FLOOR_VW.isHidden = true
            ROOM_VW.isHidden = true
            LIVINGROOM_VW.isHidden = true
            MAID_VW.isHidden = false
            HOUR_VW.isHidden = false
            total_Floor = "0"
            total_Rooms = "0"
            total_LivingRooms = "0"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_StartDateText.text = "Start Date"
            self.lbl_NoteText.text = "If you want to order a maid today, please select the time 2 hours later"
            self.lbl_selectFloorText.text = "Select Floor"
            self.lbl_HoursText.text = "How Many Hours"
        } else {
            self.lbl_StartDateText.text = "تاريخ البدء"
            self.lbl_NoteText.text = "الرجاء طلب الخدمه قبل الوقت المحدد بساعتين"
            self.lbl_selectFloorText.text = "اختر الطابق"
            self.lbl_HoursText.text = "كم عدد الساعات"
        }
    }
    
    @IBAction func btn_HowManyRooms(_ sender: UIButton) {
        dropDown1.dataSource = ["1","2","3","4"]
        dropDown1.show()
        dropDown1.anchorView = btnDrop1
        dropDown1.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown1.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnDrop1.setTitle(item, for: .normal)
            self.btnDrop1.titleLabel?.font = UIFont.systemFont(ofSize: 8)
            self.total_Rooms = item
        }
    }
    
    @IBAction func btn_HowManyLivingRoom(_ sender: UIButton)
    {
        dropDown2.dataSource = ["1","2","3","4"]
        dropDown2.show()
        dropDown2.anchorView = sender
        dropDown2.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            self.total_LivingRooms = item
        }
    }
    
    @IBAction func btn_Floor(_ sender: UIButton) {
        dropDown3.dataSource = ["1","2","3"]
        dropDown3.show()
        dropDown3.anchorView = sender
        dropDown3.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown3.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            self.total_Floor = item
        }
    }
    
    @IBAction func btn_Maid(_ sender: UIButton) {
        dropDown4.dataSource = ["1","2","3","4"]
        dropDown4.show()
        dropDown4.anchorView = btnDrop2
        dropDown4.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown4.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnDrop2.setTitle(item, for: .normal)
            self.btnDrop2.titleLabel?.font = UIFont.systemFont(ofSize: 8)
            self.total_Maids = item
        }
    }
    
    @IBAction func btn_Hours(_ sender: UIButton) {
        dropDown5.dataSource = ["1","2","3","4","5","6","7","8"]
        dropDown5.show()
        dropDown5.anchorView = sender
        dropDown5.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown5.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            self.total_Hours = item
        }
    }
    
    @IBAction func btn_StartDate(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "yyyy/MM/dd", mode: .date, type: "Date".localiz()) { date in
            sender.setTitle(date, for: .normal)
            self.start_Date = date
        }
    }
    
    @IBAction func btn_StartTime(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let selectedDate = dateFormatter.date(from: self.start_Date) {
            // Call the datePickerTapped function with the converted date
            self.datePickerTapped(strFormat: "hh:mm a", mode: .time, type: "Time".localiz(), selectedDate: selectedDate) { time in
                sender.setTitle(time, for: .normal)
                self.start_Time = time
            }
        } else {
            print("Invalid date format or value.")
        }
    }
    
    @IBAction func btn_EndTime(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "hh:mm a", mode: .time, type: "Time".localiz()) { time in
            sender.setTitle(time, for: .normal)
            self.end_Time = time
        }
    }
    
    @IBAction func btn_Next(_ sender: UIButton) {
        if start_Date.count == 0 {
            self.alert(alertmessage: "Please select the date".localiz())
        } else if start_Time.count == 0 {
            self.alert(alertmessage: "Please select the start time".localiz())
        } else {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationDetailVC") as! LocationDetailVC
            vc.cat_Id = category_Id
            vc.cat_Name = category_Name
            vc.cat_NameAr = categoryNameAR
            vc.str_StartDate = start_Date
            vc.str_StartTime = start_Time
            vc.numberOf_LivingRooms = total_LivingRooms
            vc.numberOf_Hours = total_Hours
            vc.numberOf_Floors = total_Floor
            vc.numberOf_Rooms = total_Rooms
            vc.numberOf_Maid = total_Maids
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
