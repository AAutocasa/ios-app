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
                            VStack(alignment: .leading) {
                                Text("Original ID: \(device.originalId)")
                                Text("Type: \(device.type)")
                                Text("Is Active: \(device.isActive.description)")
                                Text("Last Heartbeat: \(device.lastHeartbeat)")
                                Text("Firmware: \(device.firmware)")
                                Text("Firmware Version: \(device.firmwareVersion)")
                                Text("Role: \(device.role)")
                            }
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
