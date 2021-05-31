//
//  DeviceWorker.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation
import Combine
import Moya
import CombineMoya

protocol DeviceService: AnyObject {
    func fetchDevices() -> AnyPublisher<[Device], Error>
    func fetchDevice(with id: String) -> AnyPublisher<Device, Error>
    func activate(deviceWithId id: String) -> AnyPublisher<Device, Error>
    func deactivate(deviceWithId id: String) -> AnyPublisher<Device, Error>
}

class APIDeviceService: DeviceService {
    let provider = MoyaProvider<DeviceEndpoint>()
    
    func fetchDevices() -> AnyPublisher<[Device], Error> {
        provider.requestPublisher(.getDevices)
            .map { $0.data }
            .decode(type: [Device].self, decoder: DeviceJSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchDevice(with id: String) -> AnyPublisher<Device, Error> {
        provider.requestPublisher(.getDevice(byId: id))
            .map { $0.data }
            .decode(type: Device.self, decoder: DeviceJSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func activate(deviceWithId id: String) -> AnyPublisher<Device, Error> {
        provider.requestPublisher(.activateDevice(deviceId: id))
            .map { $0.data }
            .decode(type: Device.self, decoder: DeviceJSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func deactivate(deviceWithId id: String) -> AnyPublisher<Device, Error> {
        provider.requestPublisher(.deactivateDevice(deviceId: id))
            .map { $0.data }
            .decode(type: Device.self, decoder: DeviceJSONDecoder())
            .eraseToAnyPublisher()
    }
}
