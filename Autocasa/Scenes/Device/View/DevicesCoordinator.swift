//
//  DevicesCoordinator.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

protocol DevicesCoordinator: AnyObject {
    func presentDevice(device: Device)
}

class DefaultDevicesCoordinator: DevicesCoordinator {
    weak var delegate: CoordinatorDelegate?
    
    func setup(delegate: CoordinatorDelegate) {
        self.delegate = delegate
    }
    
    func associatedView() -> AnyView {
        let deviceService = DefaultDeviceService()
        let deviceRepository = DefaultDeviceRepository(deviceService: deviceService)
        let interactor = DefaultDevicesInteractor(deviceRepository: deviceRepository)
    
        let presenter = DefaultDevicesPresenter(coordinator: self)
        interactor.setup(delegate: presenter)
        
        let store = DevicesStore(interactor: interactor)
        presenter.setup(delegate: store)
        setup(delegate: store)
        
        return AnyView(DevicesView(store: store))
    }
    
    func presentDevice(device: Device) {
        let nextCoordinator = DefaultDeviceCoordinator()
        let nextView = nextCoordinator.associatedView(device: device)
        delegate?.renderView(nextView)
    }
}
