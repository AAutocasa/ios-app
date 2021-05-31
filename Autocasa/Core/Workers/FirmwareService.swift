//
//  FirmwareService.swift
//  Autocasa
//
//  Created by André Schueda on 31/05/21.
//

import Foundation
import Combine
import Moya
import CombineMoya

protocol FirmwareService: AnyObject {
    func fetchFirmwares() -> AnyPublisher<[Firmware], Error>
}

class DefaultFirmwareService: FirmwareService {
    let provider = MoyaProvider<FirmwareEndpoint>()
    
    func fetchFirmwares() -> AnyPublisher<[Firmware], Error> {
        provider.requestPublisher(.getFirmwares)
            .map { $0.data }
            .decode(type: [Firmware].self, decoder: FirmwareJSONDecoder())
            .eraseToAnyPublisher()
    }
}

