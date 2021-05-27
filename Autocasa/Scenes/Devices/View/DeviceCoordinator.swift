//
//  DeviceCoordinator.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

protocol DeviceCoordinator: AnyObject {
    
}

class DefaultDeviceCoordinator: DeviceCoordinator {
    func associatedView(device: Device) -> AnyView {
        let deviceService = DefaultDeviceService()
        let deviceRepository = DefaultDeviceRepository(deviceService: deviceService)
        let interactor = DefaultDeviceInteractor(deviceRepository: deviceRepository)
        
        let presenter = DefaultDevicePresenter(coordinator: self)
        interactor.setup(delegate: presenter)
        
        let store = DeviceStore(device: device, interactor: interactor)
        presenter.setup(delegate: store)
        
        // Sets the initial state for the store
        store.render(content: DeviceViewModel.Content.fromModel(model: device))
        
        return AnyView(DeviceView(store: store))
    }
}
