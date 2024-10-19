//
//  Router.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 16/02/24.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://fekhdmatko.online/webservice/"
    static let BASE_IMAGE_URL = "https://fekhdmatko.online/webservice/uploads/images/"
    
    case login
    case signup
    case forget_Password
    case verify_number
    
    case change_Password
    
    case get_Profile
    case get_BannerList
    case get_Notification
    case get_ServiceCat
    case get_OfferList
    case get_Booking
    case get_request_details
    case search_by_area
    
    case final_calculation
    
    case update_Profile
    
    case add_Review
    case add_Request
    case user_Page
    case add_payment
    case apply_offer
    
    case delete_Account
    case contact_Us
    
    public func url() -> String {
        switch self {
            
        case .login:
            return Router.oAuthPath(path: "login")
        case .signup:
            return Router.oAuthPath(path: "signup")
        case .forget_Password:
            return Router.oAuthPath(path: "forgot_password")
        case .verify_number:
            return Router.oAuthPath(path: "verify_number")
            
        case .change_Password:
            return Router.oAuthPath(path: "change_password")
            
        case .get_Profile:
            return Router.oAuthPath(path: "get_profile")
        case .get_BannerList:
            return Router.oAuthPath(path: "get_bannner_list")
        case .get_Notification:
            return Router.oAuthPath(path: "get_notification_list")
        case .get_ServiceCat:
            return Router.oAuthPath(path: "get_service_category")
        case .get_OfferList:
            return Router.oAuthPath(path: "get_offer_list")
        case .get_Booking:
            return Router.oAuthPath(path: "get_my_request_list")
        case .get_request_details:
            return Router.oAuthPath(path: "get_request_details")
            
        case .final_calculation:
            return Router.oAuthPath(path: "final_calculation")
            
        case .update_Profile:
            return Router.oAuthPath(path: "update_profile")
       
        case .add_Review:
            return Router.oAuthPath(path: "add_user_rating_review")
        case .add_Request:
            return Router.oAuthPath(path: "add_user_request")
        case .add_payment:
            return Router.oAuthPath(path: "add_payment")
        case .apply_offer:
            return Router.oAuthPath(path: "apply_offer")
            
        case .delete_Account:
            return Router.oAuthPath(path: "delete_account")
            
        case .user_Page:
            return Router.oAuthPath(path: "get_user_page")
       
        case .contact_Us:
            return Router.oAuthPath(path: "send_feedback")
       
        case .search_by_area:
            return Router.oAuthPath(path: "search_by_area")
        }
    }
    
    private static func oAuthPath(path : String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}
