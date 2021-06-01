//
//  ContentView.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import SwiftUI

struct ContentView: View {
    let coordinator = AppState.shared.mainCoordinator
    
    var body: some View {
        NavigationView { () -> AnyView in
            AnyView(
                ZStack {
                    Image("PurpleSpheres")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: UIScreen.main.bounds.width,
                               maxHeight: UIScreen.main.bounds.height)
                    HStack(alignment: .top) {
                        coordinator.associatedView()
                    }
                }
            )
        }
        .navigationTitle("Devices")
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = UIColor.clear
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
