//
//  Coordinator.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

protocol CoordinatorDelegate: AnyObject {
    func renderView(_ view: AnyView)
}

struct NavigationViewModel {
    var shouldNavigate: Bool
    var destination: AnyView?
    static var none = NavigationViewModel(shouldNavigate: false, destination: nil)
}

//NavigationView { () -> AnyView in
//    switch store.viewModel.state {
//    case .error(let error):
//        return AnyView(ErrorView(error: error))
//    case .loading:
//        return AnyView(LoadingView())
//    case .content(let content):
//        return AnyView(DeviceContentView(content: content,
//                                         finishButtonTapped: store.performAction,
//                                         navigation: $store.viewModel.navigation))
//    }
//}.onAppear(perform: store.fetchDevice)

