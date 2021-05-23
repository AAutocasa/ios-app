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
}

protocol DeviceInteractorDelegate: AnyObject {
    func presentLoading()
    func presentActivationSuccess()
    func present(device: Device)
    func present(error: Error)
}

// MARK: Implementation
class DefaultDeviceInteractor: DeviceInteractor {
    private let deviceProvider: DeviceWorker
    private weak var presenter: DeviceInteractorDelegate?
    private var cancellable: AnyCancellable?
    private var device: Device?
    
    init(deviceWorker: DeviceWorker) {
        deviceProvider = deviceWorker
    }
    
    func setup(delegate: DeviceInteractorDelegate) {
        self.presenter = delegate
    }
    
    func fetchDevice(with id: String) {
        presenter?.presentLoading()
        cancellable = deviceProvider.fetchDevice(with: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] error in
                if case .failure(let error) = error {
                    self?.presenter?.present(error: error)
                }
            }, receiveValue: { [weak self] device in
                self?.device = device
                self?.presenter?.present(device: device)
            })
    }
    
    func activateDevice() {
        guard let device = device else { return }
        cancellable = deviceProvider.activate(deviceWithId: device.originalId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] error in
                if case .failure(let error) = error {
                    self?.presenter?.present(error: error)
                }
            }, receiveValue: { [weak self] _ in
                self?.presenter?.presentActivationSuccess()
            })
    }
}
