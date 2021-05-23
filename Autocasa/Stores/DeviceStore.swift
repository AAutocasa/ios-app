//
//  DeviceStore.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

class DeviceStore: ObservableObject {
    private var deviceId: UUID
    private var interactor: DeviceInteractor
    @Published var viewModel: DeviceViewModel
    
    init(deviceId: UUID, interactor: DeviceInteractor) {
        self.deviceId = deviceId
        self.interactor = interactor
        self.viewModel = DeviceViewModel(state: .loading, navigation: .none)
    }
    
    func fetchDevice() {
        interactor.fetchDevice(with: deviceId)
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

