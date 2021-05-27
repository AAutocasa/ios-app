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
    func selectDevice(originalId: String)
}

protocol DevicesInteractorDelegate: AnyObject {
    func presentLoading()
    func present(devices: [Device])
    func present(device: Device)
    func present(error: Error)
}

// MARK: Implementation
class DefaultDevicesInteractor: DevicesInteractor {
    
    private let deviceRepository: DeviceRepository
    private var presenter: DevicesInteractorDelegate?
    private var cancellable: AnyCancellable?
    private var devices: [Device]?
    
    init(deviceRepository: DeviceRepository) {
        self.deviceRepository = deviceRepository
    }
    
    func setup(delegate: DevicesInteractorDelegate) {
        print("[DefaultDevicesInteractor] Setting up delegate for the interactor")
        self.presenter = delegate
    }
    
    func fetchDevices() {
        print("[DefaultDevicesInteractor] Fetch devices called")
        presenter?.presentLoading()
        cancellable = deviceRepository.fetchDevices()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] error in
                if case .failure(let error) = error {
                    self?.presenter?.present(error: error)
                }
            }, receiveValue: { [weak self] devices in
                print("[DefaultDevicesInteractor] Got devices: \(devices)")
                self?.devices = devices
                print("[DefaultDevicesInteractor] Sending devices to presenter \(self?.presenter)")
                self?.presenter?.present(devices: devices)
            })
    }
    
    func selectDevice(originalId: String) {
        print("[DefaultDevicesInteractor] Select device called")
        cancellable = deviceRepository.fetchDevice(with: originalId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] error in
                if case .failure(let error) = error {
                    self?.presenter?.present(error: error)
                }
            }, receiveValue: { [weak self] device in
                print("[DefaultDevicesInteractor] Got device: \(device)")
                print("[DefaultDevicesInteractor] Sending device to presenter \(self?.presenter)")
                self?.presenter?.present(device: device)
            })
    }
}
