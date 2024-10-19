//
//  Banner.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 17/02/24.
//

import Foundation

struct Api_BannerList : Codable {
    let result : [Res_BannerList]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_BannerList].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_BannerList : Codable {
    let id : String?
    let image : String?
    let link : String?
    let cat_id : String?
    let cat_name : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case image = "image"
        case link = "link"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
