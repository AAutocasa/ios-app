//
//  Inject.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 27/05/21.
//

import Foundation

@propertyWrapper
struct Inject<Component> {
    let wrappedValue: Component
    init() {
        self.wrappedValue = Resolver.shared.resolve(Component.self)
    }
}
