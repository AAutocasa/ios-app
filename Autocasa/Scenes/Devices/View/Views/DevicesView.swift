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
                        List(content.devices, id: \.id) { device in
                            NavigationLink(
                                destination: store.viewModel.navigation.destination,
                                isActive: $store.viewModel.navigation.shouldNavigate) {
                                DevicesRowView(device: device).onTapGesture {
                                    store.deviceSelected(originalId: device.originalId)
                                }
                            }
                        }
                    }
                )
                
            //AnyView(DeviceContentView(content: content,
            //  finishButtonTapped: store.performAction,
            //  navigation: $store.viewModel.navigation))
            }
        }
        .navigationTitle("Devices")
        .onAppear(perform: store.fetchDevices)
    }
}
