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
    let firmware: Int
    let firmwareVersion: String
    let status: Int
    
    var isActive: Bool {
        status != 0
    }
    
    let lastHeartbeat: Date
    let role: Int
    
    enum CodingKeys: String, CodingKey {
        case originalId = "id"
        case type
        case firmware
        case firmwareVersion
        case status
        case lastHeartbeat
        case role
    }
}

