//
//  DeviceRepository.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 27/05/21.
//

import Foundation
import Combine

protocol DeviceRepository {
    func fetchDevices() -> AnyPublisher<[Device], Error>
    func fetchDevices(filteredBy filter: @escaping (Device) -> Bool) -> AnyPublisher<[Device], Error>
    func fetchDevice(with id: String) -> AnyPublisher<Device, Error>
    func activate(deviceWithId id: String) -> AnyPublisher<Device, Error>
    func deactivate(deviceWithId id: String) -> AnyPublisher<Device, Error>
}

class DefaultDeviceRepository: DeviceRepository {
    
    @Inject private var deviceService: DeviceService
    
    private let cache = Cache<String, Device>(
        identifiedBy: { $0.originalId },
        expirationTime: 300)
    
    func fetchDevices() -> AnyPublisher<[Device], Error> {
        if cache.isValid {
            return Just(cache.get())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return deviceService.fetchDevices()
            .handleOutput { [weak self] devices in
                self?.cache.update(devices)
                self?.cache.clear()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchDevices(filteredBy filterQuery: @escaping (Device) -> Bool) -> AnyPublisher<[Device], Error> {
        fetchDevices()
            .map {
                $0.filter(filterQuery)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchDevice(with id: String) -> AnyPublisher<Device, Error> {
        if cache.isValid,
           let device = cache.get(withKey: id) {
            return Just(device)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return deviceService.fetchDevice(with: id)
            .handleOutput { [weak self] device in
                guard let cache = self?.cache else { return }
                cache.update(device)
                if !cache.isValid {
                    cache.clear()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func activate(deviceWithId id: String) -> AnyPublisher<Device, Error> {
        cache.invalidate(withKey: id)
        
        return deviceService.activate(deviceWithId: id)
            .handleOutput { [weak self] device in
                self?.cache.update(device)
            }
            .eraseToAnyPublisher()
    }
    
    func deactivate(deviceWithId id: String) -> AnyPublisher<Device, Error> {
        cache.invalidate(withKey: id)
        
        return deviceService.deactivate(deviceWithId: id)
            .handleOutput { [weak self] device in
                self?.cache.update(device)
            }
            .eraseToAnyPublisher()
    }
    
}

