//
//  ContentView.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

struct ContentView: View {
    let coordinator = DefaultDevicesCoordinator()
    
    var body: some View {
        coordinator.associatedView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
