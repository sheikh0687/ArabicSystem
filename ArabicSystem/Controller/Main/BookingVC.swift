//
//  BookingVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit
import LanguageManager_iOS

class BookingVC: UIViewController {
    
    @IBOutlet weak var btn_CurrentOt: UIButton!
    @IBOutlet weak var btn_CompletedOt: UIButton!
    
    @IBOutlet weak var tbl_Vw: UITableView!
    
    var arr_BookingRequest: [Res_Booking] = []
    
    var status:String = "Current"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl_Vw.register(UINib(nibName: "BookingCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
        btn_CurrentOt.setTitleColor(.white, for: .normal)
        btn_CurrentOt.backgroundColor = R.color.main()
        btn_CompletedOt.setTitleColor(R.color.main(), for: .normal)
        btn_CompletedOt.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Booking".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.all_Booking_Request()
        changeStaticLangauge()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Current(_ sender: UIButton) {
        status = "Current"
        btn_CurrentOt.setTitleColor(.white, for: .normal)
        btn_CurrentOt.backgroundColor = R.color.main()
        btn_CompletedOt.setTitleColor(R.color.main(), for: .normal)
        btn_CompletedOt.backgroundColor = .white
        self.all_Booking_Request()
    }
    
    @IBAction func btn_Completed(_ sender: UIButton) {
        status = "Past"
        btn_CompletedOt.setTitleColor(.white, for: .normal)
        btn_CompletedOt.backgroundColor = R.color.main()
        btn_CurrentOt.setTitleColor(R.color.main(), for: .normal)
        btn_CurrentOt.backgroundColor = .white
        self.all_Booking_Request()
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.btn_CurrentOt.setTitle("Current", for: .normal)
            self.btn_CompletedOt.setTitle("Completed", for: .normal)
        } else {
            self.btn_CurrentOt.setTitle("الحالي", for: .normal)
            self.btn_CompletedOt.setTitle("مكتمل", for: .normal)
        }
    }
}

extension BookingVC {
    
    func all_Booking_Request()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["status"] = status as AnyObject
        paramDict["language"] = k.userDefault.value(forKey: k.session.language) as AnyObject
        
        print(paramDict)
        
        Api.shared.booking_Request(self, paramDict) { responseData in
            if responseData.status == "1" {
                if let result = responseData.result {
                    self.arr_BookingRequest = result
                    self.tbl_Vw.backgroundView = UIView()
                    self.tbl_Vw.reloadData()
                }
            } else {
                self.arr_BookingRequest = []
                self.tbl_Vw.backgroundView = UIView()
                if LanguageManager.shared.currentLanguage == .en {
                    Utility.noDataFound("No Data Available", tableViewOt: self.tbl_Vw, parentViewController: self)
                } else {
                    Utility.noDataFound("لا توجد بيانات متاحة", tableViewOt: self.tbl_Vw, parentViewController: self)
                }
                self.tbl_Vw.reloadData()
            }
        }
    }
}

extension BookingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_BookingRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        let obj = self.arr_BookingRequest[indexPath.row]
        if LanguageManager.shared.currentLanguage == .en {
            cell.lbl_CategoryName.text = obj.category_name ?? ""
            if obj.category_name == "Apartment service" {
                
                cell.lbl_AllBookingDetails.text = """
                        \("Date") : \(obj.start_date ?? "")
                        \("From") : \(obj.start_time ?? "") \("to".localiz()) \(obj.end_time ?? "")
                        \("Maids") : \(obj.total_maids ?? "")
                        \("Total Rooms") : \(obj.total_rooms ?? "")
                        \("Total Living Rooms") : \(obj.total_living_rooms ?? "")
                        """
                
            } else if obj.category_name == "Vila service" {
                
                cell.lbl_AllBookingDetails.text = """
                     \("Date") : \(obj.start_date ?? "")
                     \("From") : \(obj.start_time ?? "") \("to".localiz()) \(obj.end_time ?? "")
                     \("Maids") : \(obj.total_maids ?? "")
                     \("Total Floor") : \(obj.total_floors ?? "")
                     """
                
            } else {
                
                cell.lbl_AllBookingDetails.text = """
                    \("Date") : \(obj.start_date ?? "")
                    \("From") : \(obj.start_time ?? "") \("to".localiz()) \(obj.end_time ?? "")
                    \("Maids") : \(obj.total_maids ?? "")
                    \("Total Hours") : \(obj.total_visit_hours ?? "")
                    """
                
            }
            
            cell.lbl_Amount.text = """
             Booking Fee: \(k.currency) \(obj.booking_amount ?? "")
             Tax (\(obj.tax_percentage ?? "")%): \(k.currency) \(obj.tax_amount ?? "0")
             Total Amount: \(k.currency) \(obj.total_amount ?? "")
             """
            
            cell.lbl_CurrentStatus.text = "Current Status: \(obj.status ?? "")"
            cell.btn_SeeDetails.setTitle("See Details", for: .normal)
        } else {
            cell.lbl_CategoryName.text = obj.category_name_ar ?? ""
            if obj.category_name == "Apartment service" {
                  cell.lbl_AllBookingDetails.text = """
                      تاريخ : \(obj.start_date ?? "")
                      من : \(obj.start_time ?? "") إلى \(obj.end_time ?? "")
                      عدد الخادمات : \(obj.total_maids ?? "")
                      إجمالي الغرف : \(obj.total_rooms ?? "")
                      إجمالي غرف المعيشة : \(obj.total_living_rooms ?? "")
                      """
                  
              } else if obj.category_name == "Vila service" {
                  cell.lbl_AllBookingDetails.text = """
                      تاريخ : \(obj.start_date ?? "")
                      من : \(obj.start_time ?? "") إلى \(obj.end_time ?? "")
                      عدد الخادمات : \(obj.total_maids ?? "")
                      إجمالي الطوابق : \(obj.total_floors ?? "")
                      """
                  
              } else {
                  cell.lbl_AllBookingDetails.text = """
                      تاريخ : \(obj.start_date ?? "")
                      من : \(obj.start_time ?? "") إلى \(obj.end_time ?? "")
                      عدد الخادمات : \(obj.total_maids ?? "")
                      إجمالي الساعات : \(obj.total_visit_hours ?? "")
                      """
              }
              
              cell.lbl_Amount.text = """
                  رسوم الحجز: \(k.currency) \(obj.booking_amount ?? "")
                  الضريبة (\(obj.tax_percentage ?? "")%): \(k.currency) \(obj.tax_amount ?? "0")
                  المبلغ الإجمالي: \(k.currency) \(obj.total_amount ?? "")
                  """
              
              cell.lbl_CurrentStatus.text = "الحالة الحالية: \(obj.status ?? "")"
              cell.btn_SeeDetails.setTitle("عرض التفاصيل", for: .normal)
        }
        
        let attributedString = NSMutableAttributedString(string: cell.lbl_AllBookingDetails.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // Set the desired spacing between lines
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        cell.lbl_AllBookingDetails.attributedText = attributedString
        
        cell.clo_Rate = {
            let vc = kStoryboard.instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
            vc.request_Id = obj.id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.clo_SeeDetails = {
            let vc = kStoryboard.instantiateViewController(withIdentifier: "BookingDetailVC") as! BookingDetailVC
            vc.requestId = obj.id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if status == "Complete" {
            cell.btn_RatingOt.isHidden = false
            cell.btn_Blank1.isHidden = true
            cell.btn_Blank2.isHidden = true
            cell.btn_SeeDetails.isHidden = false
        } else {
            cell.btn_RatingOt.isHidden = true
            cell.btn_Blank1.isHidden = false
            cell.btn_Blank2.isHidden = false
            cell.btn_SeeDetails.isHidden = false
        }
        
        return cell
    }
}
