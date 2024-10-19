//
//  Variable.swift
//  فخدمتكو
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import Foundation
import UIKit

var globalUserName          =       k.userDefault.value(forKey: "user_name")
var globalUserImage         =       k.userDefault.value(forKey: "user_image")

var localTimeZoneIdentifier: String { return
    TimeZone.current.identifier }

var dictSignup:[String:AnyObject] = [:]

var logout: Bool = true
