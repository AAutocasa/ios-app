//
//  DeviceViewModel.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation

struct DeviceViewModel {
    
    struct Content {
        let id: UUID
        let originalId: String
        let type: String
        let firmware: Int
        let firmwareVersion: String
        let isActive: Bool
        let lastHeartbeat: Date
        let role: Int
        
        static func fromModel(model: Device) -> DeviceViewModel.Content {
            DeviceViewModel.Content(id: model.id,
                                   originalId: model.originalId,
                                   type: model.type,
                                   firmware: model.firmware,
                                   firmwareVersion: model.firmwareVersion,
                                   isActive: model.isActive,
                                   lastHeartbeat: model.lastHeartbeat,
                                   role: model.role)
        }
    }
    
    struct Error {
        
    }
    
    enum State {
        case loading
        case content(Content)
        case error(Error)
    }
    
    var state: State
    var navigation: NavigationViewModel
}
