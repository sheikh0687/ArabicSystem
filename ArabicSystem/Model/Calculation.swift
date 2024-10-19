//
//  Calculation.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 19/03/24.
//

import Foundation

struct Api_Calculate : Codable {
    let result : Res_Calculate?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_Calculate.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_Calculate : Codable {
    let hr_rate : String?
    let base_fee : String?
    let booking_amount : String?
    let total_amount : String?
    let tax_amount: String?
    let tax : String?
    let service_fee : String?

    enum CodingKeys: String, CodingKey {

        case hr_rate = "hr_rate"
        case base_fee = "base_fee"
        case booking_amount = "booking_amount"
        case total_amount = "total_amount"
        case tax = "tax"
        case tax_amount = "tax_amount"
        case service_fee = "service_fee"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hr_rate = try values.decodeIfPresent(String.self, forKey: .hr_rate)
        base_fee = try values.decodeIfPresent(String.self, forKey: .base_fee)
        booking_amount = try values.decodeIfPresent(String.self, forKey: .booking_amount)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        tax = try values.decodeIfPresent(String.self, forKey: .tax)
        tax_amount = try values.decodeIfPresent(String.self, forKey: .tax_amount)
        service_fee = try values.decodeIfPresent(String.self, forKey: .service_fee)
    }

}
