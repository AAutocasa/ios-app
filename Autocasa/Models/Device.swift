//
//  Device.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation

class Device: Identifiable, Codable {
    var id: UUID {
        UUID()
    }
    
    let originalId: String
    let type: String
//    let firmware: Int
//    let firmwareVersion: String
//    let status: Bool
//    let lastHearbeat: Date
//    let role: Int
    
    enum CodingKeys: String, CodingKey {
        case originalId = "id"
        case type
    }
}

