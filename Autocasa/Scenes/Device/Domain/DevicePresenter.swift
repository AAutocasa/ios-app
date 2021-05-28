//
//  DevicePresenter.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation

protocol DevicePresenter: AnyObject {
    
}

protocol DevicePresenterDelegate: CoordinatorDelegate {
    func renderLoading()
    func render(content: DeviceViewModel.Content)
    func render(error: DeviceViewModel.Error)
}

// MARK: Implementation
class DefaultDevicePresenter: DevicePresenter {
    private var coordinator: DeviceCoordinator
    private weak var delegate: DevicePresenterDelegate?
    
    init(coordinator: DeviceCoordinator) {
        self.coordinator = coordinator
    }
    
    func setup(delegate: DevicePresenterDelegate) {
        self.delegate = delegate
    }
}

// MARK: DefaultDevicePresenter: DeviceInteractorDelegate
extension DefaultDevicePresenter: DeviceInteractorDelegate {
    
    typealias VMContent = DeviceViewModel.Content
    typealias VMError = DeviceViewModel.Error
    
    func presentLoading() {
        delegate?.renderLoading()
    }
    
    func present(device: Device) {
        print("[DefaultDevicePresenter] Present claled with device \(device)")
        delegate?.render(content: contentViewModel(from: device))
    }
    
    private func contentViewModel(from device: Device) -> VMContent {
        // TODO: Converter model em view model
        return DeviceViewModel.Content.fromModel(model: device)
    }
    
    func present(error: Error) {
        delegate?.render(error: errorViewModel(from: error))
    }
    
    private func errorViewModel(from error: Error) -> VMError {
        // TODO: Converter erro em view model
        return VMError()
    }
    
}
