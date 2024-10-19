//
//  AmountVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 14/02/24.
//

import UIKit
import LanguageManager_iOS
import PLPaymentGateway

struct PaylinkConfig {
    static let testURL = "https://restpilot.paylink.sa"
    static let liveURL = "https://restapi.paylink.sa"
    static let secretKey = "6492b3c8-f0af-3b6b-9459-076ec9af8ccc"
    static let secretKeyTest = "0662abb5-13c7-38ab-cd12-236e58f43766"
    static let appID = "APP_ID_1716674401585"
    static let appIDTest = "APP_ID_1123453311"
}

class AmountVC: UIViewController {
    
    @IBOutlet weak var lbl_ServiceFor: UILabel!
    
    @IBOutlet weak var lbl_TotalMaids: UILabel!
    @IBOutlet weak var lbl_TotalRooms: UILabel!
    @IBOutlet weak var lbl_HowManyLivingRoom: UILabel!
    @IBOutlet weak var lbl_Floor: UILabel!
    @IBOutlet weak var lbl_HowManyHours: UILabel!
    
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
    @IBOutlet weak var lbl_Discount: UILabel!
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
    @IBOutlet weak var lbl_FloorText: UILabel!
    @IBOutlet weak var lbl_HowManyHourText: UILabel!
    @IBOutlet weak var lbl_DiscountText: UILabel!
    
    @IBOutlet weak var ROOMVW: UIStackView!
    @IBOutlet weak var LIVINGROOMVW: UIStackView!
    @IBOutlet weak var FLOORVW: UIStackView!
    @IBOutlet weak var HOURVW: UIStackView!
    
    @IBOutlet weak var view_1: UIView!
    @IBOutlet weak var btn_Apply: UIButton!
    @IBOutlet weak var txt_ApplyOffer: UITextField!
    
    var cat_Id = ""
    var cat_Name = ""
    var cat_NameAr = ""
    
    var start_Date = ""
    var start_Time = ""
    var end_Time = ""
    
    var total_Rooms = ""
    var total_LivingRooms = ""
    var total_Maids = ""
    var total_Floor = ""
    var total_Hours = ""
    
    var address = ""
    var lat = ""
    var lon = ""
    
    var beach_Name = ""
    var house_Type = ""
    var house_Number = ""
    var description_ = ""
    
    var offer_Code = ""
    var offer_Id = ""
    
    var payment_Type = ""
    
    var gateway = PaylinkGateway(environment: .prod)
    
    var hour_Rate = ""
    var base_Amount = ""
    var booking_Amount = ""
    var taxAmount = ""
    var taxPercent = ""
    var total_Amount = ""
    
    var strApplied:String = ""
    
    let isEnglish = LanguageManager.shared.currentLanguage == .en
    
    override func viewDidLoad() {
        super.viewDidLoad()
        identifiersssWithData()
        self.changeStaticLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Total Amount".localiz(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.lbl_EndTimeHeading.text = "End Time".localiz()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func changeStaticLanguage() {
        // Update labels based on the language
        self.lbl_BookinkForText.text = isEnglish ? "Booking For" : "الحجز لـ"
        self.lbl_AprtmentText.text = isEnglish ? cat_Name : cat_NameAr
        self.lbl_HowManyRoomText.text = isEnglish ? "How many Rooms" : "كم عدد الغرف"
        self.lbl_HowManyLivingRoomText.text = isEnglish ? "How many living Rooms" : "كم عدد غرف المعيشة"
        self.lbl_DateText.text = isEnglish ? "Date" : "التاريخ"
        self.lbl_VillaText.text = isEnglish ? "Villa or Appartment" : "فيلا أو شقة"
        self.lbl_AddressText.text = isEnglish ? "Address" : "العنوان"
        self.lbl_BookinkFeeText.text = isEnglish ? "Booking Fee" : "رسوم الحجز"
        self.lbl_TaxText.text = isEnglish ? "Tax" : "الضريبة"
        self.lbl_FloorText.text = isEnglish ? "Floor" : "الطابق"
        self.lbl_HowManyHourText.text = isEnglish ? "How Many Hours" : "كم عدد الساعات"
    }
    
    @IBAction func btn_Apply(_ sender: UIButton) {
        if self.txt_ApplyOffer.hasText {
            if strApplied.isEmpty {
                self.applyOffers()
            } else {
                self.alert(alertmessage: "You have already applied the code")
            }
        } else {
            self.alert(alertmessage: "Please enter the correct code")
        }
    }
    
    @IBAction func btn_Pay(_ sender: UIButton) {
        self.add_User_Request()
    }
}

// MARK: Get All Request and Calculation Api
extension AmountVC {
    
    func identifiersssWithData()
    {
        if cat_Name == "Apartment service" {
            self.lbl_TotalMaids.text = self.total_Maids
            self.lbl_TotalRooms.text = self.total_Rooms
            self.lbl_HowManyLivingRoom.text = self.total_LivingRooms
            self.lbl_Date.text = self.start_Date
            self.lbl_StartTime.text = self.start_Time
            
            self.FLOORVW.isHidden = true
            self.HOURVW.isHidden = true
            self.ROOMVW.isHidden = false
            self.LIVINGROOMVW.isHidden = false
            
        } else if cat_Name == "Vila service" {
            self.lbl_TotalMaids.text = self.total_Maids
//            self.lbl_TotalRooms.text = self.total_Rooms
//            self.lbl_HowManyLivingRoom.text = self.total_LivingRooms
            self.lbl_Date.text = self.start_Date
            self.lbl_StartTime.text = self.start_Time
            self.lbl_Floor.text = self.total_Floor
            
            self.HOURVW.isHidden = true
            self.ROOMVW.isHidden = true
            self.LIVINGROOMVW.isHidden = true
            self.FLOORVW.isHidden = false

        } else {
            self.lbl_TotalMaids.text = self.total_Maids
            self.lbl_HowManyHours.text = self.total_Hours
            
            self.FLOORVW.isHidden = true
            self.ROOMVW.isHidden = true
            self.LIVINGROOMVW.isHidden = true
            self.HOURVW.isHidden = false
        }
        
        self.lbl_BeachName.text = self.beach_Name
        self.lbl_VillaAppartmentNum.text = self.house_Number
        self.lbl_Address.text = self.address
        
        Api.shared.final_AmountCalculation(self, param_ForCalculation()) { responseData in
            let obj = responseData
            self.lbl_BaseFee.text = "\(k.currency) \(obj.base_fee ?? "")"
            self.lbl_BookingFee.text = "\(k.currency) \(obj.service_fee ?? "")"
            self.lbl_TotalFinalAmnt.text = "\(k.currency) \(obj.total_amount ?? "")"
            
            self.lbl_TaxText.text = self.isEnglish ? "Tax: (\(obj.tax ?? "")%)" : "الضريبة: (\(obj.tax ?? "")%)"
            self.lbl_Tax.text = "\(k.currency) \(obj.tax_amount ?? "")"
            
            self.base_Amount = obj.base_fee ?? ""
            self.hour_Rate = obj.hr_rate ?? ""
            self.booking_Amount = obj.service_fee ?? ""
            self.total_Amount = obj.total_amount ?? ""
            self.taxAmount = obj.tax_amount ?? ""
            self.taxPercent = obj.tax ?? ""
        }
        
        func param_ForCalculation() -> [String : AnyObject]
        {
            var dict: [String : AnyObject] = [:]
            dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
            dict["cat_id"]                 = cat_Id as AnyObject
            dict["no_of_maid"]             = total_Maids as AnyObject
            dict["total_hr"]               = total_Hours as AnyObject
            dict["total_floor"]            = total_Floor as AnyObject
            dict["total_room"]             = total_Rooms as AnyObject
            
            print(dict)
            
            return dict
        }
    }
    
    func applyOffers()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["amount"] = self.total_Amount as AnyObject
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["offer_code"] = self.txt_ApplyOffer.text as AnyObject
        
        print(paramDict)
        
        Api.shared.apply_Offer(self, paramDict) { responseData in
            let obj = responseData
            if obj.status == "1" {
                self.btn_Apply.setTitle("Applied", for: .normal)
                self.strApplied = "Applied"
                self.lbl_TotalFinalAmnt.text = "\(k.currency) \(obj.after_discount ?? "")"
                self.total_Amount = obj.after_discount ?? ""
                self.lbl_Discount.text = "-\(k.currency) \(obj.discount ?? "")"
            } else {
                self.alert(alertmessage: obj.message ?? "")
            }
        }
    }
}

// MARK: Add Request Api
extension AmountVC {
    
    func add_User_Request()
    {
        Api.shared.add_User_Request(self, param_AddRequest()) { responseData in
            let obj = responseData
            self.showProgressBar()
            self.openPaymentGateway(serviceName: obj.category_name ?? "", totalAmount: obj.total_amount ?? "", orderId: obj.id ?? "")
        }
    }
    
    func param_AddRequest() -> [String : AnyObject]
    {
        var dict: [String : AnyObject]       = [:]
        dict["user_id"]                      = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["category_id"]                  = cat_Id as AnyObject
        dict["category_name"]                = cat_Name as AnyObject
        dict["category_name_ar"]             = cat_NameAr as AnyObject
        dict["start_date"]                   = start_Date as AnyObject
        dict["start_time"]                   = start_Time as AnyObject
        dict["end_time"]                     = end_Time as AnyObject
        dict["end_date"]                     = k.emptyString as AnyObject
        dict["total_visit_hours"]            = total_Hours as AnyObject
        dict["total_rooms"]                  = total_Rooms as AnyObject
        dict["total_floors"]                 = total_Floor as AnyObject
        dict["total_living_rooms"]           = total_LivingRooms as AnyObject
        dict["total_maids"]                  = total_Maids as AnyObject
        dict["tax_amount"]                   = taxAmount as AnyObject
        dict["tax_percentage"]               = taxPercent as AnyObject
        dict["address"]                      = address as AnyObject
        dict["lat"]                          = lat as AnyObject
        dict["lon"]                          = lon as AnyObject
        dict["branch"]                       = beach_Name as AnyObject
        dict["house_type"]                   = k.emptyString as AnyObject
        dict["house_number"]                 = house_Number as AnyObject
        dict["total_amount"]                 = total_Amount as AnyObject
        dict["hr_rate"]                      = hour_Rate as AnyObject
        dict["base_fee"]                     = base_Amount as AnyObject
        dict["booking_amount"]               = booking_Amount as AnyObject
        dict["description"]                  = k.emptyString as AnyObject
        dict["offer_code"]                   = k.emptyString as AnyObject
        dict["offer_id"]                     = k.emptyString as AnyObject
        dict["payment_type"]                 = k.emptyString as AnyObject
        
        print(dict)
        
        return dict
    }
}

// MARK: Configure Paylink Payment Gateway
extension AmountVC {
    
    func openPaymentGateway(serviceName: String, totalAmount: String, orderId: String) {
        self.authenticatePaylink { token in
            guard let token = token else {
                print("Authentication failed")
                return
            }
            
            let serviceName = serviceName
            let totalAmount = totalAmount
            let orderId = orderId
            let callbackURL = "https://yourbackend.com/payment-callback"
            let clientName = k.userDefault.value(forKey: k.session.userName) as? String
            let clientMobile = k.userDefault.value(forKey: k.session.mobileNum) as? String
            
            self.addInvoice(token: token, serviceName: serviceName, totalAmount: totalAmount, orderId: orderId, callbackURL: callbackURL, clientName: clientName ?? "", clientMobile: clientMobile ?? "") { transactionNo in
                print(transactionNo ?? "")
                guard let transactionNo = transactionNo else {
                    print("Failed to create invoice")
                    self.hideProgressBar()
                    return
                }
                DispatchQueue.main.async {
                    self.openPaymentViewController(transactionNo: transactionNo, token: token, request_id: orderId)
                }
            }
        }
    }
    
    func authenticatePaylink(completion: @escaping (String?) -> Void) {
        let url = URL(string: "\(PaylinkConfig.liveURL)/api/auth")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let authParams: [String: Any] = [
            "apiId": PaylinkConfig.appID,
            "secretKey": PaylinkConfig.secretKey,
            "persistToken": true
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: authParams)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(response ?? "")
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let token = json["id_token"] as? String {
                    DispatchQueue.main.async {
                        completion(token)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                print("JSON parsing error: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    func addInvoice(token: String, serviceName: String, totalAmount: String, orderId: String, callbackURL: String, clientName: String, clientMobile: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "\(PaylinkConfig.liveURL)/api/addInvoice")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let productObject: [String: Any] = [
            "title": serviceName,
            "price": totalAmount,
            "qty": "1",
            "description": "",
            "isDigital": "",
            "imageSrc": "",
            "specificVat": "",
            "productCost": ""
        ]
        
        let invoiceObject: [String: Any] = [
            "orderNumber": orderId,
            "amount": totalAmount,
            "callBackUrl": callbackURL,
            "clientName": clientName,
            "clientMobile": clientMobile,
            "products": [productObject]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: invoiceObject)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(String(describing: error))")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let transactionNo = json["transactionNo"] as? String {
                    DispatchQueue.main.async {
                        completion(transactionNo)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                print("JSON parsing error: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    func getInvoice(token: String, transactionNo: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "\(PaylinkConfig.liveURL)/api/getInvoice/\(transactionNo)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(String(describing: error))")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let orderStatus = json["orderStatus"] as? String {
                    DispatchQueue.main.async {
                        completion(orderStatus)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                print("JSON parsing error: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    func openPaymentViewController(transactionNo: String,token: String, request_id: String) {
        DispatchQueue.main.async {
            guard let viewController = self.navigationController else {
                // Handle error, navigation controller is nil
                print("Something went wrong")
                return
            }
            self.hideProgressBar()
            self.gateway.openPaymentForm(transactionNo: transactionNo, from: viewController) {
                result in
                switch result {
                    // After payment is completed (Paid or Declined), orderNumber
                    // and transactionNo are returned.
                case .success((let orderNumber, let transactionNo)):
                    print("order number: \(orderNumber)")
                    print("transaction no: \(transactionNo)")
                    DispatchQueue.main.async {
                        self.getInvoice(token: token, transactionNo: transactionNo) { orderStatus in
                            print(orderStatus ?? "")
                            if orderStatus == "Paid" {
                                self.paymentConfirmation(transactionId: transactionNo, request_Id: request_id)
                            } else {
                                self.alert(alertmessage: "Something went wrong".localiz())
                            }
                        }
                    }
                    break;
                case .failure(_):
                    print("Fail due to some reason")
                    break;
                }
            } loaded: {
                // .. code when the ViewController got loaded.
            }
        }
    }
    
    func paymentConfirmation(transactionId: String, request_Id: String)
    {
        var param: [String : AnyObject] = [:]
        param["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        param["request_id"] = request_Id as AnyObject
        param["payment_method"] = "Card" as AnyObject
        param["total_amount"] = total_Amount as AnyObject
        param["transaction_id"] = transactionId as AnyObject
        
        print(param)
        
        Api.shared.add_PaymentConfirmation(self, param) { responseData in
            DispatchQueue.main.async {
                Utility.showAlertWithAction(withTitle: k.appName, message: "Payment done successfully".localiz(), delegate: nil, parentViewController: self) { bool in
                    Switcher.check_LoginStatus()
                }
            }
        }
    }
}
