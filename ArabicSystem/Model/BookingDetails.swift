//
//  BookingDetails.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 27/09/24.
//

import Foundation

struct Api_BookingDetails : Codable {
    
    let result : Res_BookingDetails?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_BookingDetails.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_BookingDetails : Codable {
    let id : String?
    let user_id : String?
    let provider_id : String?
    let accept_provider_id : String?
    let total_amount : String?
    let hr_rate : String?
    let base_fee : String?
    let booking_amount : String?
    let provider_amount : String?
    let admin_commission : String?
    let admin_VAT : String?
    let tax_amount : String?
    let tax_percentage : String?
    let discount : String?
    let wallet_used_amount : String?
    let accept_one_hr : String?
    let category_id : String?
    let category_name : String?
    let category_name_ar : String?
    let address : String?
    let lat : String?
    let lon : String?
    let branch : String?
    let house_type : String?
    let house_number : String?
    let start_date : String?
    let start_time : String?
    let end_date : String?
    let end_time : String?
    let offer_id : String?
    let offer_code : String?
    let offer_percentage : String?
    let total_visit_hours : String?
    let total_maids : String?
    let total_rooms : String?
    let total_living_rooms : String?
    let unique_code : String?
    let description : String?
    let payment_type : String?
    let payment_status : String?
    let status : String?
    let date_time : String?
    let date_time_last : String?
    let date_time_two_hr : String?
    let timezone : String?
    let request_type : String?
    let reason_title : String?
    let reason_detail : String?
    let payment_confirmation : String?
    let rating : String?
    let feedback : String?
    let user_details : User_details?
    let rating_review_status : String?
    let format_date : String?
    let total_floors: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case provider_id = "provider_id"
        case accept_provider_id = "accept_provider_id"
        case total_amount = "total_amount"
        case hr_rate = "hr_rate"
        case base_fee = "base_fee"
        case booking_amount = "booking_amount"
        case provider_amount = "provider_amount"
        case admin_commission = "admin_commission"
        case admin_VAT = "admin_VAT"
        case tax_amount = "tax_amount"
        case tax_percentage = "tax_percentage"
        case discount = "discount"
        case wallet_used_amount = "wallet_used_amount"
        case accept_one_hr = "accept_one_hr"
        case category_id = "category_id"
        case category_name = "category_name"
        case category_name_ar = "category_name_ar"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case branch = "branch"
        case house_type = "house_type"
        case house_number = "house_number"
        case start_date = "start_date"
        case start_time = "start_time"
        case end_date = "end_date"
        case end_time = "end_time"
        case offer_id = "offer_id"
        case offer_code = "offer_code"
        case offer_percentage = "offer_percentage"
        case total_visit_hours = "total_visit_hours"
        case total_maids = "total_maids"
        case total_rooms = "total_rooms"
        case total_living_rooms = "total_living_rooms"
        case unique_code = "unique_code"
        case description = "description"
        case payment_type = "payment_type"
        case payment_status = "payment_status"
        case status = "status"
        case date_time = "date_time"
        case date_time_last = "date_time_last"
        case date_time_two_hr = "date_time_two_hr"
        case timezone = "timezone"
        case request_type = "request_type"
        case reason_title = "reason_title"
        case reason_detail = "reason_detail"
        case payment_confirmation = "payment_confirmation"
        case rating = "rating"
        case feedback = "feedback"
        case user_details = "user_details"
        case rating_review_status = "rating_review_status"
        case format_date = "format_date"
        case total_floors = "total_floors"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        accept_provider_id = try values.decodeIfPresent(String.self, forKey: .accept_provider_id)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        hr_rate = try values.decodeIfPresent(String.self, forKey: .hr_rate)
        base_fee = try values.decodeIfPresent(String.self, forKey: .base_fee)
        booking_amount = try values.decodeIfPresent(String.self, forKey: .booking_amount)
        provider_amount = try values.decodeIfPresent(String.self, forKey: .provider_amount)
        admin_commission = try values.decodeIfPresent(String.self, forKey: .admin_commission)
        admin_VAT = try values.decodeIfPresent(String.self, forKey: .admin_VAT)
        tax_amount = try values.decodeIfPresent(String.self, forKey: .tax_amount)
        tax_percentage = try values.decodeIfPresent(String.self, forKey: .tax_percentage)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        wallet_used_amount = try values.decodeIfPresent(String.self, forKey: .wallet_used_amount)
        accept_one_hr = try values.decodeIfPresent(String.self, forKey: .accept_one_hr)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        category_name_ar = try values.decodeIfPresent(String.self, forKey: .category_name_ar)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        branch = try values.decodeIfPresent(String.self, forKey: .branch)
        house_type = try values.decodeIfPresent(String.self, forKey: .house_type)
        house_number = try values.decodeIfPresent(String.self, forKey: .house_number)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        offer_code = try values.decodeIfPresent(String.self, forKey: .offer_code)
        offer_percentage = try values.decodeIfPresent(String.self, forKey: .offer_percentage)
        total_visit_hours = try values.decodeIfPresent(String.self, forKey: .total_visit_hours)
        total_maids = try values.decodeIfPresent(String.self, forKey: .total_maids)
        total_rooms = try values.decodeIfPresent(String.self, forKey: .total_rooms)
        total_living_rooms = try values.decodeIfPresent(String.self, forKey: .total_living_rooms)
        unique_code = try values.decodeIfPresent(String.self, forKey: .unique_code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        date_time_last = try values.decodeIfPresent(String.self, forKey: .date_time_last)
        date_time_two_hr = try values.decodeIfPresent(String.self, forKey: .date_time_two_hr)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        request_type = try values.decodeIfPresent(String.self, forKey: .request_type)
        reason_title = try values.decodeIfPresent(String.self, forKey: .reason_title)
        reason_detail = try values.decodeIfPresent(String.self, forKey: .reason_detail)
        payment_confirmation = try values.decodeIfPresent(String.self, forKey: .payment_confirmation)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        feedback = try values.decodeIfPresent(String.self, forKey: .feedback)
        user_details = try values.decodeIfPresent(User_details.self, forKey: .user_details)
        rating_review_status = try values.decodeIfPresent(String.self, forKey: .rating_review_status)
        format_date = try values.decodeIfPresent(String.self, forKey: .format_date)
        total_floors = try values.decodeIfPresent(String.self, forKey: .total_floors)
    }
}

struct User_details : Codable {
    let id : String?
    let store_id : String?
    let first_name : String?
    let last_name : String?
    let store_name : String?
    let mobile : String?
    let mobile_with_code : String?
    let mobile1 : String?
    let mobile_with_code1 : String?
    let email : String?
    let password : String?
    let country_id : String?
    let state_id : String?
    let state_name : String?
    let city_id : String?
    let city_name : String?
    let image : String?
    let type : String?
    let social_id : String?
    let lat : String?
    let lon : String?
    let address : String?
    let addresstype : String?
    let address_id : String?
    let gender : String?
    let gender_type : String?
    let wallet : String?
    let earn_points : String?
    let referal_points : String?
    let booking_points : String?
    let referral_code : String?
    let signup_referral_code : String?
    let licence_image : String?
    let licence_id : String?
    let licence_issue_date : String?
    let licence_expire_date : String?
    let register_id : String?
    let ios_register_id : String?
    let status : String?
    let approve_status : String?
    let available_status : String?
    let code : String?
    let date_time : String?
    let cat_id : String?
    let cat_name : String?
    let bank_name : String?
    let branch_name : String?
    let iban_id : String?
    let account_number : String?
    let bank_emirates : String?
    let owner_name : String?
    let tax_number : String?
    let store_logo : String?
    let store_cover_image : String?
    let about_store : String?
    let outdoor_service : String?
    let indoor_service : String?
    let note : String?
    let note_block : String?
    let block_unblock : String?
    let remove_status : String?
    let open_time : String?
    let close_time : String?
    let store_ope_closs_status : String?
    let area : String?
    let area_id : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case store_id = "store_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case store_name = "store_name"
        case mobile = "mobile"
        case mobile_with_code = "mobile_with_code"
        case mobile1 = "mobile1"
        case mobile_with_code1 = "mobile_with_code1"
        case email = "email"
        case password = "password"
        case country_id = "country_id"
        case state_id = "state_id"
        case state_name = "state_name"
        case city_id = "city_id"
        case city_name = "city_name"
        case image = "image"
        case type = "type"
        case social_id = "social_id"
        case lat = "lat"
        case lon = "lon"
        case address = "address"
        case addresstype = "addresstype"
        case address_id = "address_id"
        case gender = "gender"
        case gender_type = "gender_type"
        case wallet = "wallet"
        case earn_points = "earn_points"
        case referal_points = "referal_points"
        case booking_points = "booking_points"
        case referral_code = "referral_code"
        case signup_referral_code = "signup_referral_code"
        case licence_image = "licence_image"
        case licence_id = "licence_id"
        case licence_issue_date = "licence_issue_date"
        case licence_expire_date = "licence_expire_date"
        case register_id = "register_id"
        case ios_register_id = "ios_register_id"
        case status = "status"
        case approve_status = "approve_status"
        case available_status = "available_status"
        case code = "code"
        case date_time = "date_time"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case bank_name = "bank_name"
        case branch_name = "branch_name"
        case iban_id = "Iban_id"
        case account_number = "account_number"
        case bank_emirates = "bank_emirates"
        case owner_name = "owner_name"
        case tax_number = "tax_number"
        case store_logo = "store_logo"
        case store_cover_image = "store_cover_image"
        case about_store = "about_store"
        case outdoor_service = "outdoor_service"
        case indoor_service = "indoor_service"
        case note = "note"
        case note_block = "note_block"
        case block_unblock = "block_unblock"
        case remove_status = "remove_status"
        case open_time = "open_time"
        case close_time = "close_time"
        case store_ope_closs_status = "store_ope_closs_status"
        case area = "area"
        case area_id = "area_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        store_name = try values.decodeIfPresent(String.self, forKey: .store_name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        mobile_with_code = try values.decodeIfPresent(String.self, forKey: .mobile_with_code)
        mobile1 = try values.decodeIfPresent(String.self, forKey: .mobile1)
        mobile_with_code1 = try values.decodeIfPresent(String.self, forKey: .mobile_with_code1)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        state_id = try values.decodeIfPresent(String.self, forKey: .state_id)
        state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        addresstype = try values.decodeIfPresent(String.self, forKey: .addresstype)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        gender_type = try values.decodeIfPresent(String.self, forKey: .gender_type)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
        earn_points = try values.decodeIfPresent(String.self, forKey: .earn_points)
        referal_points = try values.decodeIfPresent(String.self, forKey: .referal_points)
        booking_points = try values.decodeIfPresent(String.self, forKey: .booking_points)
        referral_code = try values.decodeIfPresent(String.self, forKey: .referral_code)
        signup_referral_code = try values.decodeIfPresent(String.self, forKey: .signup_referral_code)
        licence_image = try values.decodeIfPresent(String.self, forKey: .licence_image)
        licence_id = try values.decodeIfPresent(String.self, forKey: .licence_id)
        licence_issue_date = try values.decodeIfPresent(String.self, forKey: .licence_issue_date)
        licence_expire_date = try values.decodeIfPresent(String.self, forKey: .licence_expire_date)
        register_id = try values.decodeIfPresent(String.self, forKey: .register_id)
        ios_register_id = try values.decodeIfPresent(String.self, forKey: .ios_register_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        approve_status = try values.decodeIfPresent(String.self, forKey: .approve_status)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        bank_name = try values.decodeIfPresent(String.self, forKey: .bank_name)
        branch_name = try values.decodeIfPresent(String.self, forKey: .branch_name)
        iban_id = try values.decodeIfPresent(String.self, forKey: .iban_id)
        account_number = try values.decodeIfPresent(String.self, forKey: .account_number)
        bank_emirates = try values.decodeIfPresent(String.self, forKey: .bank_emirates)
        owner_name = try values.decodeIfPresent(String.self, forKey: .owner_name)
        tax_number = try values.decodeIfPresent(String.self, forKey: .tax_number)
        store_logo = try values.decodeIfPresent(String.self, forKey: .store_logo)
        store_cover_image = try values.decodeIfPresent(String.self, forKey: .store_cover_image)
        about_store = try values.decodeIfPresent(String.self, forKey: .about_store)
        outdoor_service = try values.decodeIfPresent(String.self, forKey: .outdoor_service)
        indoor_service = try values.decodeIfPresent(String.self, forKey: .indoor_service)
        note = try values.decodeIfPresent(String.self, forKey: .note)
        note_block = try values.decodeIfPresent(String.self, forKey: .note_block)
        block_unblock = try values.decodeIfPresent(String.self, forKey: .block_unblock)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        open_time = try values.decodeIfPresent(String.self, forKey: .open_time)
        close_time = try values.decodeIfPresent(String.self, forKey: .close_time)
        store_ope_closs_status = try values.decodeIfPresent(String.self, forKey: .store_ope_closs_status)
        area = try values.decodeIfPresent(String.self, forKey: .area)
        area_id = try values.decodeIfPresent(String.self, forKey: .area_id)
    }

}
