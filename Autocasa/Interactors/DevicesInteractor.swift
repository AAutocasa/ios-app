//
//  DevicesInteractor.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation
import Combine

protocol DevicesInteractor: AnyObject {
    func fetchDevices()
}

protocol DevicesInteractorDelegate: AnyObject {
    func presentLoading()
    func present(devices: [Device])
    func present(error: Error)
}

// MARK: Implementation
class DefaultDevicesInteractor: DevicesInteractor {
    
    private let deviceProvider: DeviceWorker
    private var presenter: DevicesInteractorDelegate?
    private var cancellable: AnyCancellable?
    private var devices: [Device]?
    
    init(deviceWorker: DeviceWorker) {
        deviceProvider = deviceWorker
    }
    
    func setup(delegate: DevicesInteractorDelegate) {
        print("Setting up delegate for the interactor")
        self.presenter = delegate
    }
    
    func fetchDevices() {
        presenter?.presentLoading()
        cancellable = deviceProvider.fetchDevices()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] error in
                if case .failure(let error) = error {
                    self?.presenter?.present(error: error)
                }
            }, receiveValue: { [weak self] devices in
                print("Got devices: \(devices)")
                self?.devices = devices
                print("Sending devices to presenter \(self?.presenter)")
                self?.presenter?.present(devices: devices)
            })
    }
}
