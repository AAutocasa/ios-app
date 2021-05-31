//
//  AppState.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 31/05/21.
//

import Foundation

class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var mainCoordinator = DefaultDevicesCoordinator()
}
