//
//  Publisher+.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 27/05/21.
//

import Foundation
import Combine

extension Publisher {
    func handleOutput(_ action: @escaping (Self.Output) -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveOutput: { value in
            action(value)
        })
    }
}
