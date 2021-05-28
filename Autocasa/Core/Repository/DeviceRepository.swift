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
        print("[DeviceRepository] Fetching all devices...")
        if cache.isValid {
            print("[DeviceRepository] Cache is valid! Returning cache")
            return Just(cache.get())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        print("[DeviceRepository] Cache invalid. Querying...")
        return deviceService.fetchDevices()
            .handleOutput { [weak self] devices in
                self?.cache.update(devices)
                self?.cache.clear()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchDevices(filteredBy filterQuery: @escaping (Device) -> Bool) -> AnyPublisher<[Device], Error> {
        print("[DeviceRepository] Fetching devices but filtered...")
        return fetchDevices()
            .map {
                $0.filter(filterQuery)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchDevice(with id: String) -> AnyPublisher<Device, Error> {
        print("[DeviceRepository] Fetching a single device...")
        if cache.isValid,
           let device = cache.get(withKey: id) {
            print("[DeviceRepository] Cache hit! Returning cached")
            return Just(device)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        print("[DeviceRepository] Cache invalid/miss! Querying...")
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
        print("[DeviceRepository] Activating device...")
        cache.invalidate(withKey: id)
        
        return deviceService.activate(deviceWithId: id)
            .handleOutput { [weak self] device in
                self?.cache.update(device)
            }
            .eraseToAnyPublisher()
    }
    
    func deactivate(deviceWithId id: String) -> AnyPublisher<Device, Error> {
        print("[DeviceRepository] Deactivating device...")
        cache.invalidate(withKey: id)
        
        return deviceService.deactivate(deviceWithId: id)
            .handleOutput { [weak self] device in
                self?.cache.update(device)
            }
            .eraseToAnyPublisher()
    }
    
}

