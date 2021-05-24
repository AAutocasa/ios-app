//
//  DevicesStore.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

class DevicesStore: ObservableObject {
    private var interactor: DevicesInteractor
    @Published var viewModel: DevicesViewModel
    
    init(interactor: DevicesInteractor) {
        self.interactor = interactor
        self.viewModel = DevicesViewModel(state: .loading, navigation: .none)
    }
    
    func fetchDevices() {
        interactor.fetchDevices()
    }
    
    func deviceSelected(originalId: String) {
        print("[DeviceStore] Received tap on row with id: \(originalId)")
        interactor.selectDevice(originalId: originalId)
    }
}

extension DevicesStore: DevicesPresenterDelegate {
    
    func renderLoading() {
        self.viewModel.state = .loading
    }
    
    func render(content: DevicesViewModel.Content) {
        print("[DeviceStore] Rendering devices: \(content)")
        self.viewModel.state = .content(content)
    }
    
    func render(error: DevicesViewModel.Error) {
        print("[DeviceStore] Rendering error: \(error)")
        self.viewModel.state = .error(error)
    }
    
    func renderView(_ view: AnyView) {
        print("[DeviceStore] Render view called...")
        viewModel.navigation.destination = view
        viewModel.navigation.shouldNavigate = true
    }
}

