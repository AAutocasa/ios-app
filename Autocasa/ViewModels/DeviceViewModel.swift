//
//  DeviceViewModel.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation

struct DevicesViewModel {
    struct Content {
        let devices: [DeviceViewModel.Content]
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


struct DeviceViewModel {
    static func fromModel(model: Device) -> DeviceViewModel.Content {
        return DeviceViewModel.Content(id: model.id,
                                       originalId: model.originalId,
                                       type: model.type)
    }
    
    struct Content {
        let id: UUID
        let originalId: String
        let type: String
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
