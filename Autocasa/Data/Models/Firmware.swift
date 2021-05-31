//
//  Firmware.swift
//  Autocasa
//
//  Created by André Schueda on 31/05/21.
//

import Foundation

class Firmware: Codable {
    let name: String
    let code: Int
    let possibleRoles: [FirmwareRole]
    
    enum CodingKeys: String, CodingKey {
        case name = "firmwareName"
        case code = "firmwareCode"
        case possibleRoles
    }
}
