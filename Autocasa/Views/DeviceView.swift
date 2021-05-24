//
//  DeviceView.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 24/05/21.
//

import SwiftUI

struct DeviceView: View {
    @ObservedObject var store: DeviceStore
    
    var navigationTitle: String {
        switch store.viewModel.state {
        case .error, .loading:
            return "Device"
        case .content(let content):
            return content.originalId
        }
    }
    
    var body: some View {
        NavigationView { () -> AnyView in
            switch store.viewModel.state {
            case .error:
                return AnyView(
                    Text("Error!")
                )
            case .loading:
                return AnyView(
                    Text("Loading")
                )
            case .content(let content):
                return AnyView(
                    VStack {
                        Text("This is the page for the device \(content.id)")
                    }
                )
            //AnyView(DeviceContentView(content: content,
            //  finishButtonTapped: store.performAction,
            //  navigation: $store.viewModel.navigation))
            }
        }
        .navigationTitle(navigationTitle)
        .onAppear(perform: store.fetchDevice)
    }
}
