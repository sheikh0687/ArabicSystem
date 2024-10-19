//
//  Request.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 19/02/24.
//

import Foundation

struct Api_AddRequest : Codable {
    let result : Res_AddRequest?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_AddRequest.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_AddRequest : Codable {
    let id : String?
    let user_id : String?
    let provider_id : String?
    let accept_provider_id : String?
    let total_amount : String?
    let provider_amount : String?
    let admin_commission : String?
    let admin_VAT : String?
    let discount : String?
    let wallet_used_amount : String?
    let accept_one_hr : String?
    let category_id : String?
    let category_name : String?
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
    let tax_amount: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case provider_id = "provider_id"
        case accept_provider_id = "accept_provider_id"
        case total_amount = "total_amount"
        case provider_amount = "provider_amount"
        case admin_commission = "admin_commission"
        case admin_VAT = "admin_VAT"
        case discount = "discount"
        case wallet_used_amount = "wallet_used_amount"
        case accept_one_hr = "accept_one_hr"
        case category_id = "category_id"
        case category_name = "category_name"
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
        case tax_amount = "tax_amount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        accept_provider_id = try values.decodeIfPresent(String.self, forKey: .accept_provider_id)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        provider_amount = try values.decodeIfPresent(String.self, forKey: .provider_amount)
        admin_commission = try values.decodeIfPresent(String.self, forKey: .admin_commission)
        admin_VAT = try values.decodeIfPresent(String.self, forKey: .admin_VAT)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        wallet_used_amount = try values.decodeIfPresent(String.self, forKey: .wallet_used_amount)
        accept_one_hr = try values.decodeIfPresent(String.self, forKey: .accept_one_hr)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
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
        tax_amount = try values.decodeIfPresent(String.self, forKey: .tax_amount)
    }

}
