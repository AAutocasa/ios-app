//
//  DevicesView.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

struct DevicesView: View {
    @ObservedObject var store: DevicesStore
    
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
                        Text("Devices")
                        List(content.devices, id: \.id) { device in
                            Text(device.originalId)
                            Text(device.type)
                            Text(device.isActive.description)
                            Text(device.lastHeartbeat.description)
                            Text(device.)
                        }
                    }
                )

//AnyView(DeviceContentView(content: content,
//  finishButtonTapped: store.performAction,
//  navigation: $store.viewModel.navigation))
            }
        }.onAppear(perform: store.fetchDevices)
    }
}
