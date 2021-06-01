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
        HStack(alignment: .top) {
            switch store.viewModel.state {
            case .error:
                Text("Error!")
            case .loading:
                Text("Loading")
            case .content(let content):
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
        }
        .onAppear(perform: store.fetchDevices)
        
    }
}
