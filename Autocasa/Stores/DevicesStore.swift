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
}

extension DevicesStore: DevicesPresenterDelegate {
    
    func renderLoading() {
        self.viewModel.state = .loading
    }
    
    func render(content: DevicesViewModel.Content) {
        print("Rendering devices: \(content)")
        self.viewModel.state = .content(content)
    }
    
    func render(error: DevicesViewModel.Error) {
        print("Rendering error: \(error)")
        self.viewModel.state = .error(error)
    }
    
    func renderView(_ view: AnyView) {
        viewModel.navigation.destination = view
        viewModel.navigation.shouldNavigate = true
    }
}

