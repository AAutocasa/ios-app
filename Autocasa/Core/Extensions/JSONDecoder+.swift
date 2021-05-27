//
//  JSONDecoder+.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation

extension JSONDecoder {
    func withDateDecodingStrategy(_ strategy: JSONDecoder.DateDecodingStrategy) -> JSONDecoder {
        dateDecodingStrategy = strategy
        return self
    }
}

class DeviceJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        dateDecodingStrategy = .millisecondsSince1970
    }
}
