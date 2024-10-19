//
//  VerifyNumber.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 04/06/24.
//

import Foundation

struct Api_VerifyNumber : Codable {
    let result : ResVerifyNumber?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResVerifyNumber.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResVerifyNumber : Codable {
    let code : Int?

    enum CodingKeys: String, CodingKey {

        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }
}
