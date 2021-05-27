//
//  DevicesViewModel.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 24/05/21.
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
