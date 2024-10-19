//
//  Api.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 16/02/24.
//

import Foundation

class Api: NSObject {
    
    static let shared = Api()
    
    func paramGetUserId() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.string(forKey: k.session.userId) as AnyObject
        print(dict)
        return dict
    }
    
    func login(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Res_Base) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.login.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Base.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.type)
                    k.userDefault.set(k.emptyString, forKey: k.session.userName)
                    k.userDefault.set(k.emptyString, forKey: k.session.mobileNum)
//                    k.userDefault.set(k.emptyString, forKey: k.session.customerId)
//                    k.userDefault.set(k.emptyString, forKey: k.session.userMobile)
//                    k.userDefault.set(k.emptyString, forKey: k.session.mobileWithCode)
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong")
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func signup(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Res_Base) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.signup.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Base.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.type)
                    k.userDefault.set(k.emptyString, forKey: k.session.userName)
//                    k.userDefault.set(k.emptyString, forKey: k.session.customerId)
                    k.userDefault.set(k.emptyString, forKey: k.session.mobileNum)
//                    k.userDefault.set(k.emptyString, forKey: k.session.mobileWithCode)
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong")
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func forget_Password(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.forget_Password.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func verifyOtp(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResVerifyNumber) -> Void) {
        vc.blockUi()
        Service.post(url: Router.verify_number.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_VerifyNumber.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func change_Password(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.change_Password.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func user_Profile(_ vc: UIViewController,_ success: @escaping(_ responseData : Res_Base) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_Profile.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Base.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func update_UserProfile(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : Res_Base) -> Void) {
        vc.showProgressBar()
        Service.postSingleMedia(url: Router.update_Profile.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Base.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func banner_List(_ vc: UIViewController,_ success: @escaping(_ responseData : [Res_BannerList]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_BannerList.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_BannerList.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func notification_List(_ vc: UIViewController,_ success: @escaping(_ responseData : Api_Notification) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_Notification.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Notification.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func service_Category(_ vc: UIViewController,_ success: @escaping(_ responseData : [Res_ServiceCategory]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_ServiceCat.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ServiceCategory.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func offer_Lists(_ vc: UIViewController,_ success: @escaping(_ responseData : [Res_OfferList]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_OfferList.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_OfferrList.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func booking_Request(_ vc: UIViewController,_ param : [String : AnyObject],_ success: @escaping(_ responseData : Api_Booking) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_Booking.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Booking.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func booking_RequestDetails(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData : Res_BookingDetails) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_request_details.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_BookingDetails.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func final_AmountCalculation(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : Res_Calculate) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.final_calculation.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Calculate.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func add_UserRating(_ vc: UIViewController, _ param: [String : AnyObject], _ success: @escaping(_ responseData : Res_Review) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.add_Review.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Review.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func add_User_Request(_ vc: UIViewController, _ param: [String : AnyObject], _ success: @escaping(_ responseData : Res_AddRequest) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.add_Request.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_AddRequest.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func add_PaymentConfirmation(_ vc: UIViewController, _ param: [String : AnyObject], _ success: @escaping(_ responseData : Res_AddPayment) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.add_payment.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_AddPayment.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func apply_Offer(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData : Api_ApplyOffer) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.apply_offer.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ApplyOffer.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func delete_Account(_ vc: UIViewController, _ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.delete_Account.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func user_Page_Detail(_ vc: UIViewController,_ success: @escaping(_ responseData : ResCondition) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.user_Page.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Terms.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func contactUs(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResContact) -> Void) {
        vc.blockUi()
        Service.post(url: Router.contact_Us.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiContactUs.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        vc.unBlockUi()
                        success(result)
                    }
                } else {
                    vc.unBlockUi()
                    vc.alert(alertmessage: root.message ?? "")
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func search_ServiceArea(_ vc: UIViewController,_ param: [String : AnyObject], _ success: @escaping(_ responseData : Api_SearchArea) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.search_by_area.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_SearchArea.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
}
