//
//  FirmwareRole.swift
//  Autocasa
//
//  Created by André Schueda on 31/05/21.
//

import Foundation

class FirmwareRole: Codable {
    let name: String
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "roleName"
        case code = "roleCode"
    }
}
