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
    let status: DeviceStatus
    
    var isActive: Bool? {
        status.isActive
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

enum DeviceStatus: Int, Codable {
    case unknown = -1
    case active = 0
    case inactive = 1
    
    var isActive: Bool? {
        if self == .unknown { return nil }
        else if self == .active { return true }
        else { return false }
    }
}
