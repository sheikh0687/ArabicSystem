//
//  PaylinkApi.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 10/06/24.
//

import Foundation

class PaylinkAPI {
    
    static let shared = PaylinkAPI()
    private init(){}
    
    static func authenticate(completion: @escaping (String?) -> Void) {
        let url = URL(string: "\(PaylinkConfig.testURL)/api/auth")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let authParams: [String: Any] = [
            "apiId": PaylinkConfig.appIDTest,
            "secretKey": PaylinkConfig.secretKeyTest,
            "persistToken": true
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: authParams)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let token = json["id_token"] as? String {
                    completion(token)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    static func addInvoice(token: String, serviceName: String, totalAmount: String, orderId: String, callbackURL: String, clientName: String, clientMobile: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "\(PaylinkConfig.testURL)/api/addInvoice")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let productObject: [String: Any] = [
            "productName": serviceName,
            "unitPrice": totalAmount,
            "qty": 1
        ]
        
        let invoiceParams: [String: Any] = [
            "orderNumber": orderId,
            "products": [productObject],
            "callBackUrl": callbackURL,
            "clientName": clientName,
            "clientMobile": clientMobile
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: invoiceParams)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let transactionNo = json["transactionNo"] as? String {
                    completion(transactionNo)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    static func getInvoiceStatus(token: String, transactionNo: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "\(PaylinkConfig.testURL)/api/invoiceStatus/\(transactionNo)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let orderStatus = json["orderStatus"] as? String {
                    completion(orderStatus)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
