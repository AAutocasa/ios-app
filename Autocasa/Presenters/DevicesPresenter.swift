//
//  DevicesPresenter.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation

protocol DevicesPresenter: AnyObject {
    
}

protocol DevicesPresenterDelegate: AnyObject, CoordinatorDelegate {
    func renderLoading()
    func render(content: DevicesViewModel.Content)
    func render(error: DevicesViewModel.Error)
}

// MARK: Implementation
class DefaultDevicesPresenter: DevicesPresenter {
    private var coordinator: DevicesCoordinator
    private weak var delegate: DevicesPresenterDelegate?
    
    init(coordinator: DevicesCoordinator) {
        self.coordinator = coordinator
    }
    
    func setup(delegate: DevicesPresenterDelegate) {
        self.delegate = delegate
    }
}

// MARK: DefaultDevicesPresenter: DevicesInteractorDelegate
extension DefaultDevicesPresenter: DevicesInteractorDelegate {
    
    typealias VMContent = DevicesViewModel.Content
    typealias VMError = DevicesViewModel.Error
    
    func presentLoading() {
        delegate?.renderLoading()
    }
    
    func present(devices: [Device]) {
        print("Presenting devices: \(devices)")
        delegate?.render(content: contentViewModel(from: devices))
    }
    
    private func contentViewModel(from devices: [Device]) -> VMContent {
        // TODO: Converter model em view model
        return VMContent(devices: devices.map({ DeviceViewModel.fromModel(model: $0) }))
    }
    
    func present(error: Error) {
        delegate?.render(error: errorViewModel(from: error))
    }
    
    private func errorViewModel(from error: Error) -> VMError {
        // TODO: Converter erro em view model
        return VMError()
    }
    
}
