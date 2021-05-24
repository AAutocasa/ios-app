//
//  DevicesRowView.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

struct DevicesRowView: View {
    @State var device: DeviceViewModel.Content
    
    var body: some View {
        // Mostra um device em formato de row
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

//struct DevicesRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        DevicesRowView(device: DeviceV)
//    }
//}
