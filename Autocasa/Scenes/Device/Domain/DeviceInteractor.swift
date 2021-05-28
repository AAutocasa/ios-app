//
//  DeviceInteractor.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation
import Combine

protocol DeviceInteractor: AnyObject {
    func fetchDevice(with id: String)
    func activateDevice()
    func deactivateDevice()
}

protocol DeviceInteractorDelegate: AnyObject {
    func presentLoading()
    func present(device: Device)
    func present(error: Error)
}

// MARK: Implementation
class DefaultDeviceInteractor: DeviceInteractor {
    private var presenter: DeviceInteractorDelegate?
    private var cancellable: AnyCancellable?
    private var device: Device?

    @Inject private var deviceRepository: DeviceRepository
    
    
    func setup(delegate: DeviceInteractorDelegate) {
        self.presenter = delegate
    }
    
    func fetchDevice(with id: String) {
        print("[DefaultDeviceInteractor] Fetch device called with ID: \(id)")
        presenter?.presentLoading()
        cancellable = deviceRepository.fetchDevice(with: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] error in
                if case .failure(let error) = error {
                    self?.presenter?.present(error: error)
                }
            }, receiveValue: { [weak self] device in
                print("[DefaultDeviceInteractor] Received device \(device)")
                self?.device = device
                self?.presenter?.present(device: device)
            })
    }
    
    func activateDevice() {
        guard let device = device else { return }
        cancellable = deviceRepository.activate(deviceWithId: device.originalId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] error in
                if case .failure(let error) = error {
                    self?.presenter?.present(error: error)
                }
            }, receiveValue: { [weak self] device in
                self?.presenter?.present(device: device)
            })
    }
    
    func deactivateDevice() {
        guard let device = device else { return }
        cancellable = deviceRepository.deactivate(deviceWithId: device.originalId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] error in
                if case .failure(let error) = error {
                    self?.presenter?.present(error: error)
                }
            }, receiveValue: { [weak self] device in
                self?.presenter?.present(device: device)
            })
    }
}
