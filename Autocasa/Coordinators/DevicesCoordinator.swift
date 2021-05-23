//
//  DevicesCoordinator.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

protocol DevicesCoordinator: AnyObject {
    func presentDevice()
}

class DefaultDevicesCoordinator: DevicesCoordinator {
    func associatedView() -> AnyView {
        let deviceProvider = DefaultDeviceWorker()
        let interactor = DefaultDevicesInteractor(deviceWorker: deviceProvider)
        let presenter = DefaultDevicesPresenter(coordinator: self)
        interactor.setup(delegate: presenter)
        let store = DevicesStore(interactor: interactor)
        presenter.setup(delegate: store)
        return AnyView(DevicesView(store: store))
    }
    
    func presentDevice() {
        // TBD
    }
}
