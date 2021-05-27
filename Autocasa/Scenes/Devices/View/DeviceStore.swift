//
//  DeviceStore.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

class DeviceStore: ObservableObject {
    private var device: Device
    private var interactor: DeviceInteractor
    @Published var viewModel: DeviceViewModel
    
    init(device: Device, interactor: DeviceInteractor) {
        self.device = device
        self.interactor = interactor
        self.viewModel = DeviceViewModel(state: .loading, navigation: .none)
    }
    
    func fetchDevice() {
        interactor.fetchDevice(with: device.originalId)
    }
    
    func performAction() {
        interactor.activateDevice()
    }
    
}

extension DeviceStore: DevicePresenterDelegate {
    func renderLoading() {
        self.viewModel.state = .loading
    }
    
    func render(content: DeviceViewModel.Content) {
        print("[DeviceStore] Rendering with content \(content)")
        self.viewModel.state = .content(content)
    }
    
    func render(error: DeviceViewModel.Error) {
        self.viewModel.state = .error(error)
    }
    
    func renderView(_ view: AnyView) {
        viewModel.navigation.destination = view
        viewModel.navigation.shouldNavigate = true
    }
}

