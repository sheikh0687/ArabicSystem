//
//  SearchArea.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 19/09/24.
//

import Foundation

struct Api_SearchArea : Codable {
    let result : String?
    let message : String?
    let message_ar : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case message_ar = "message_ar"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        message_ar = try values.decodeIfPresent(String.self, forKey: .message_ar)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
