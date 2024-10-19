//
//  ServiceCategory.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 17/02/24.
//

import Foundation

struct Api_ServiceCategory : Codable {
    let result : [Res_ServiceCategory]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_ServiceCategory].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_ServiceCategory : Codable {
    let id : String?
    let name : String?
    let name_ar : String?
    let price : String?
    let image : String?
    let status : String?
    let remove_status : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case name_ar = "name_ar"
        case price = "price"
        case image = "image"
        case status = "status"
        case remove_status = "remove_status"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
